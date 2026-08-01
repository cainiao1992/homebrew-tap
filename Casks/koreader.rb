# koreader.rb — 指向本 tap Releases 中重新托管的 KOReader macOS 构建
#
# 上游仅以 GitHub Actions artifact 形式分发 macOS 构建：需登录令牌才能下载，
# 且 90 天后过期，无法直接写入 cask。本仓库的 publish-koreader.yml 工作流负责
# 把上游产物重新打包发布到 Releases(tag 形如 koreader_2026.07)，公开且长期有效。
#
# 版本更新流程:
#   1. 运行 publish-koreader.yml 工作流(可传入目标版本号)
#   2. 从运行日志读取两个架构的 sha256，更新下方 version 与 sha256
#   3. 校验: brew style --cask koreader && brew audit --cask --online koreader
#
# 说明: 上游二进制为 ad-hoc 签名(identifier rocks.koreader)且未经公证，
#       postflight 移除 quarantine 属性以避免「app 已损坏」拦截。

cask "koreader" do
  arch arm: "arm64", intel: "x86_64"

  version "2026.07"
  sha256 arm:   "f1685c9ded2d123a1476d7973e559b74596e8c74d368803091bd268cdd399e5f",
         intel: "27fc8fc63620c4acb2248b6a3349dfcbd253f0cdcac4e318a9b8bf39506d6463"

  url "https://github.com/cainiao1992/homebrew-tap/releases/download/koreader_#{version}/KOReader-macos-#{arch}-v#{version}.zip",
      verified: "github.com/cainiao1992/homebrew-tap/"
  name "KOReader"
  desc "Ebook reader supporting PDF, DjVu, EPUB, FB2 and more"
  homepage "https://github.com/koreader/koreader"

  # 追踪上游发版；上游出新版后需重跑 publish-koreader.yml 才能更新本 cask
  livecheck do
    url "https://github.com/koreader/koreader"
    strategy :github_latest
  end

  # 取自 Info.plist 的 LSMinimumSystemVersion: arm64 为 11.0、x86_64 为 10.15。
  # 统一声明 11.0：符号形式表示「不低于」，且 brew audit 要求声明值与 artifact
  # 实际值一致(10.15 等于 Homebrew 支持下限，审计对该值不作校验)。
  depends_on macos: :big_sur

  app "KOReader.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/KOReader.app"]
  end

  zap trash: [
    "~/Library/Application Support/koreader",
    "~/Library/Caches/koreader",
    "~/Library/Preferences/rocks.koreader.plist",
    "~/Library/Saved Application State/rocks.koreader.savedState",
  ]
end
