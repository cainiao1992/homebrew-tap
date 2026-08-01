#!/usr/bin/env bash
#
# install-koreader.sh
# macOS 上自动化安装 KOReader 的辅助脚本。
#
# 背景: KOReader 官方不在 GitHub Release 页提供 macOS 二进制包，仅通过 GitHub
#       Actions 产物(artifact)分发(命名如 koreader-macos-11.0-arm64-v2026.07-*.7z)。
#       这些产物需要登录令牌下载，且 90 天后过期，因此无法写进标准 Homebrew cask。
#       本脚本封装 Wiki 文档中的手动流程:
#       https://github.com/koreader/koreader/wiki/Installation-on-MacOS
#
# 用法:
#   ./install-koreader.sh                  # 默认从 rehost 仓库 Release 下载(无需令牌)
#   ./install-koreader.sh --from artifact  # 退回: 用 $GITHUB_TOKEN 从上游 Actions 产物下载
#   ./install-koreader.sh --token <TOKEN>  # 显式传入令牌(仅 artifact 模式需要)
#   ./install-koreader.sh --file <path>    # 使用本地已下载的 .7z/.zip 文件
#   ./install-koreader.sh --dry-run        # 仅打印将要执行的操作，不下载/安装
#   ./install-koreader.sh --help           # 查看帮助
#
# 说明: KOReader.app 未经签名/公证，首次启动需在「系统设置 → 隐私与安全性」
#       中点击「仍要打开」。脚本会移除 quarantine 扩展属性以降低拦截概率。

set -euo pipefail

REPO="koreader/koreader"
APP_NAME="KOReader.app"
INSTALL_DIR="/Applications"
ARTIFACT_API="https://api.github.com/repos/${REPO}/actions/artifacts"

# rehost 仓库: 本 tap 自己的 Releases(由 publish-koreader.yml 工作流维护)
RELEASE_REPO="${KOREADER_RELEASE_REPO:-cainiao1992/homebrew-tap}"

# 运行期可覆盖
GITHUB_TOKEN="${GITHUB_TOKEN:-}"
LOCAL_FILE=""
FROM="release"   # release(默认,公开无需令牌) | artifact(需令牌,从上游 Actions 产物)
DRY_RUN=false
VERSION=""
RELEASE_TAG=""

# ---- 终端配色（非交互/管道下自动关闭）----
if [ -t 1 ]; then
  C_RED=$'\033[0;31m'; C_GRN=$'\033[0;32m'; C_YEL=$'\033[0;33m'; C_BLU=$'\033[0;34m'; C_RST=$'\033[0m'
else
  C_RED=""; C_GRN=""; C_YEL=""; C_BLU=""; C_RST=""
fi
log()  { printf '%s[INFO]%s %s\n'   "$C_BLU" "$C_RST" "$*"; }
warn() { printf '%s[WARN]%s %s\n'   "$C_YEL" "$C_RST" "$*"; }
err()  { printf '%s[ERROR]%s %s\n'  "$C_RED" "$C_RST" "$*" >&2; }
ok()   { printf '%s[OK]%s %s\n'     "$C_GRN" "$C_RST" "$*"; }

usage() {
  sed -n '2,40p' "$0" | sed 's/^# \{0,1\}//'
  exit "${1:-0}"
}

# ---- 参数解析 ----
while [ $# -gt 0 ]; do
  case "$1" in
    --token)   GITHUB_TOKEN="$2"; shift 2 ;;
    --file)    LOCAL_FILE="$2";   shift 2 ;;
    --from)    FROM="$2";         shift 2 ;;
    --dry-run) DRY_RUN=true;      shift   ;;
    --help|-h) usage 0 ;;
    *) err "未知参数: $1"; usage 1 ;;
  esac
done

# ---- 平台校验 ----
if [ "$(uname -s)" != "Darwin" ]; then
  err "本脚本仅支持 macOS。当前系统: $(uname -s)"
  exit 1
fi

# ---- 架构检测 ----
HOST_ARCH="$(uname -m)"
if [ "$HOST_ARCH" = "arm64" ]; then
  # Apple Silicon: 产物标注 11.0，最低 macOS 11.0
  ART_SUFFIX="11.0-arm64"
  MIN_MACOS="11.0"
else
  # Intel: 产物标注 10.15，最低 macOS 10.15
  ART_SUFFIX="10.15-x86_64"
  MIN_MACOS="10.15"
fi
log "检测到架构: $HOST_ARCH (目标产物后缀 $ART_SUFFIX, 最低 macOS $MIN_MACOS)"

MIN_VER="$(sw_vers -productVersion 2>/dev/null || echo '0')"
log "当前系统版本: $MIN_VER"

# ---- 依赖检测 ----
need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    warn "缺少命令: $1"
    return 1
  fi
  return 0
}

HAS_7Z=0; HAS_UNZIP=0; HAS_UNAR=0
need_cmd 7z  && HAS_7Z=1
need_cmd unzip && HAS_UNZIP=1
need_cmd unar && HAS_UNAR=1

if [ "$HAS_7Z" -eq 0 ] && [ "$HAS_UNAR" -eq 0 ]; then
  err "需要 7z 或 unar 才能解压 .7z 产物。请先安装其一:"
  err "    brew install p7zip     # 提供 7z"
  err "    brew install unar      # 提供 unar"
  exit 1
fi
if [ "$HAS_UNZIP" -eq 0 ] && [ -z "$LOCAL_FILE" ]; then
  # 仅通过 API 下载时才需要 unzip 拆解 artifact 容器
  warn "缺少 unzip，可能无法拆解 GitHub 返回的 artifact 容器(zip)。建议: brew install p7zip"
fi

# ---- 工作目录 ----
WORK="$(mktemp -d -t koreader-install.XXXXXX)"
cleanup() { rm -rf "$WORK"; }
trap cleanup EXIT

# ---- 获取产物源 ----
SRC_FILE=""

fetch_release() {
  # 从 rehost 仓库 Releases 拉取公开资源（无需令牌）
  local repo="$1" arch="$2"
  local info tag url
  info="$(curl -sSL "https://api.github.com/repos/${repo}/releases/latest")"
  tag="$(printf '%s' "$info" | python3 -c 'import sys,json;print(json.load(sys.stdin).get("tag_name",""))')"
  [ -n "$tag" ] || { err "无法获取 $repo 的最新 release（可能尚未发布）"; return 1; }
  VERSION="${tag#*_}"
  RELEASE_TAG="$tag"
  url="https://github.com/${repo}/releases/download/${tag}/KOReader-macos-${arch}-v${VERSION}.zip"
  echo "$url"
}

if [ -n "$LOCAL_FILE" ]; then
  if [ ! -f "$LOCAL_FILE" ]; then
    err "本地文件不存在: $LOCAL_FILE"
    exit 1
  fi
  log "使用本地文件: $LOCAL_FILE"
  SRC_FILE="$LOCAL_FILE"
elif [ "$FROM" = "artifact" ]; then
  # 退回模式: 用令牌从上游 Actions artifact 下载(需登录、产物会过期)
  if [ -z "$GITHUB_TOKEN" ]; then
    err "artifact 模式需提供 GitHub 令牌(GITHUB_TOKEN 或 --token)。"
    err "或改用默认 release 模式(无需令牌)，或 --file 指定本地文件。"
    exit 1
  fi
  log "通过 GitHub API 查找最新 macOS 产物 ($ART_SUFFIX) ..."

  # 列出产物，筛选匹配后缀且未过期者，按创建时间取最新
  PAYLOAD="$(curl -sSL -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    "${ARTIFACT_API}?per_page=100")"

  ART_ID="$(printf '%s' "$PAYLOAD" | python3 - "$ART_SUFFIX" <<'PY'
import sys, json
suffix = sys.argv[1]
try:
    data = json.loads(sys.stdin.read())
except Exception as e:
    sys.stderr.write("解析产物列表失败: %s\n" % e); sys.exit(2)
arts = data.get("artifacts", [])
cands = [a for a in arts
         if (a.get("name","").startswith("koreader-macos-"+suffix))
         and not a.get("expired")]
if not cands:
    sys.stderr.write("未找到匹配 %s 的未过期产物\n" % suffix); sys.exit(3)
cands.sort(key=lambda a: a.get("created_at",""), reverse=True)
print(cands[0]["id"])
PY
)"
  if [ -z "$ART_ID" ] || [ "$ART_ID" = "0" ]; then
    err "未找到可用的 macOS 产物。"
    exit 1
  fi
  log "选中产物 ID: $ART_ID"

  API_URL="${ARTIFACT_API}/${ART_ID}/zip"
  if [ "$DRY_RUN" = true ]; then
    log "[dry-run] 将下载: $API_URL -> $WORK/artifact.zip"
  else
    curl -sSL -H "Authorization: Bearer ${GITHUB_TOKEN}" \
      -H "Accept: application/vnd.github+json" \
      -L "$API_URL" -o "$WORK/artifact.zip"
    ok "已下载 artifact 容器 -> $WORK/artifact.zip"
  fi
  SRC_FILE="$WORK/artifact.zip"
else
  # 默认 release 模式: 从 rehost 仓库公开下载(无需令牌)
  URL="$(fetch_release "$RELEASE_REPO" "$HOST_ARCH")" || exit 1
  if [ "$DRY_RUN" = true ]; then
    log "[dry-run] 将从 rehost release 下载: $URL"
  else
    curl -sSL -L "$URL" -o "$WORK/release.zip" \
      || { err "下载失败，请确认 rehost 仓库已发布对应架构资源: $URL"; exit 1; }
    ok "已下载: $URL"
  fi
  SRC_FILE="$WORK/release.zip"
fi

# ---- 解压 ----
extract_inner() {
  # 参数: 输入文件 -> 解压到 $WORK，输出最终 .7z 或 .app 的路径
  local f="$1"
  if [[ "$f" == *.7z ]]; then
    if [ "$HAS_7Z" -eq 1 ]; then
      7z x -y -o"$WORK" "$f" >/dev/null
    else
      unar -o "$WORK" "$f" >/dev/null
    fi
  elif [[ "$f" == *.zip ]]; then
    if [ "$HAS_UNZIP" -eq 1 ]; then
      unzip -o -q "$f" -d "$WORK"
    else
      unar -o "$WORK" "$f" >/dev/null
    fi
  fi
}

if [ "$DRY_RUN" = true ]; then
  log "[dry-run] 将解压: $SRC_FILE -> $WORK，并定位 $APP_NAME"
else
  extract_inner "$SRC_FILE"

  # 容器 zip 内通常是同名的 .7z，需要再解一层
  INNER_7Z="$(find "$WORK" -maxdepth 2 -name '*.7z' | head -n1 || true)"
  if [ -n "$INNER_7Z" ]; then
    log "检测到内层 .7z: $INNER_7Z，继续解压 ..."
    extract_inner "$INNER_7Z"
  fi

  APP_PATH="$(find "$WORK" -maxdepth 3 -name "$APP_NAME" -type d | head -n1 || true)"
  if [ -z "$APP_PATH" ]; then
    err "解压后未找到 $APP_NAME。请检查产物内容或手动解压后使用 --file 指定目录。"
    exit 1
  fi
  ok "已定位应用: $APP_PATH"
fi

# ---- 安装 ----
TARGET="${INSTALL_DIR}/${APP_NAME}"
if [ "$DRY_RUN" = true ]; then
  log "[dry-run] 将安装: ${APP_PATH:-<app>} -> $TARGET"
else
  if [ -d "$TARGET" ]; then
    warn "目标已存在，先移除旧版本: $TARGET"
    rm -rf "$TARGET"
  fi
  cp -R "$APP_PATH" "$TARGET"
  ok "已安装到 $TARGET"
fi

# ---- 去除 quarantine ----
if [ "$DRY_RUN" = true ]; then
  log "[dry-run] 将执行: xattr -dr com.apple.quarantine $TARGET"
else
  if command -v xattr >/dev/null 2>&1; then
    xattr -dr com.apple.quarantine "$TARGET" 2>/dev/null || true
    ok "已移除 quarantine 扩展属性"
  fi
fi

# ---- 完成提示 ----
cat <<EOF

${C_GRN}KOReader 安装完成。${C_RST}
后续步骤:
  1. 首次启动需在「系统设置 → 隐私与安全性」中点击「仍要打开」
     (KOReader 未经签名/公证，这是 macOS Gatekeeper 的预期行为)。
  2. 命令行调用: 将以下内容加入 ~/.zshrc
       export PATH="\$PATH:/Applications/KOReader.app/Contents/MacOS"
EOF
