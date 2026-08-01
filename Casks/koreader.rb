# koreader.rb — Homebrew cask (指向本 tap 自己 Releases 中重新托管的 macOS 构建)
#
# 该 cask 的资源由 .github/workflows/publish-koreader.yml 工作流发布到本仓库的
# Releases(tag 形如 koreader_2026.07)，公开且长期有效，解决了上游仅以 ephemeral、
# 需登录的 Actions artifact 分发 macOS 构建、无法写进标准 cask 的问题。
#
# 使用前:
#   1. 运行一次 publish-koreader.yml 工作流，生成 Releases 与资源。
#   2. 将下方 version 与 sha256 替换为实际发布值(工作流运行日志会打印 sha256)。
#   3. 校验: brew style --cask koreader && brew audit --cask --online koreader
#
# 说明: KOReader.app 未经签名/公证，postflight 移除 quarantine 以降低「app 已损坏」拦截。

cask "koreader" do
  version "2026.07"   # 必须与 rehost 仓库的 release tag (v2026.07) 保持一致

  name "KOReader"
  desc "Open-source ebook reader with versatile format support"  # 不以冠词开头
  homepage "https://github.com/koreader/koreader"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  # 实际最低版本需从 KOReader.app/Contents/Info.plist 的 LSMinimumSystemVersion 读取
  # (arm64 约 11.0，x86_64 约 10.15)；此处取较高值以覆盖两者。
  depends_on macos: ">= :big_sur"

  on_macos do
    rehost = "cainiao1992/homebrew-tap"
    arch arm: "arm64", intel: "x86_64"
    sha256 arm: "REPLACE_WITH_ARM64_SHA256",
           intel: "REPLACE_WITH_X86_SHA256"
    url "https://github.com/#{rehost}/releases/download/koreader_#{version}/KOReader-macos-#{arch}-v#{version}.zip"

    app "KOReader.app"

    postflight do
      system_command "xattr",
                     args: ["-dr", "com.apple.quarantine", appdir/"KOReader.app"]
    end

    zap trash: [
      "~/Library/Application Support/koreader",
      "~/Library/Caches/koreader",
    ]
  end
end
