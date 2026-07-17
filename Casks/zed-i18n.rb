cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.11.3-i18n.1"

  language "cs" do
    sha256 arm:          "ba693a1354ea895cb38190c86c11445a85d2503703156ccaa2921acb4393c270",
           intel:        "0d4dcb34422c16718371be43eed4ddc233bc4c9b1820091486d543ea41c99d28",
           arm64_linux:  "271c1d663107284ae5ef3e726b4512331cbc15506db9288251bddf4ab792291b",
           x86_64_linux: "1e9a6e0b686cf9df44ff4835e1bf06f71fbfe134a3d1f48cfdb2418ddb4cfb72"
    "cs-CZ"
  end
  language "de" do
    sha256 arm:          "5253dec94158c3b7c259127f0b53e789dfd04e2dc6e0dabd4cc79b3c75b8b90b",
           intel:        "68865b75b4979c1ebae7b995ff3351a9257c3d337f69dc40f765815f8a2ed4d0",
           arm64_linux:  "328e5db52e855a002a3f6e1d0085afe394e379aa6e7297d728614be78a3dc174",
           x86_64_linux: "a13e9d565242bac2925bf402374dd0d2335fe7ee6c0ea0ec0a497cfeb3ed1b67"
    "de-DE"
  end
  language "es" do
    sha256 arm:          "5e0f2b5762724e3891eb3bb5286c947ba57af569e2df870205b03c844a9c9af4",
           intel:        "200dffa6a714c23ad7bc8eacdcdfe1d5d6ca41e018e32a0838e0c5e3e9443393",
           arm64_linux:  "7b181b5bba55395352644d3f8c2314e286fa900d25c0da274f4f889cf356646e",
           x86_64_linux: "fdce787d4d93c1acba21fd527a6330b8c86ae34affa0f316a4ead96f29189b2c"
    "es-ES"
  end
  language "fr" do
    sha256 arm:          "09c1fd9bef84885c568cf4195f8f6239f7fb8d5df24dd6a3f410b140e912053d",
           intel:        "71ad86a91b41e4d92aa2300ee28dc6549bc8dea8d8e228b5252f4a1a55d33ebb",
           arm64_linux:  "30a98c4b6986bce9cf3c3f06cbf8e709155d8cba9e27f583e5b2d3e0ac4bd12e",
           x86_64_linux: "c66f5fca96d4e20c340ee97533f53f56253c71be33240da3701e43acbd9a87f1"
    "fr-FR"
  end
  language "it" do
    sha256 arm:          "52da5a6fe04e2c7ca9439700fa100afb46fda212a3576c64942b76b6a480fb75",
           intel:        "ecae4c6400dadccc1021d8691e782b3051ed8f79c3b0c4a1b885b246d6b157f9",
           arm64_linux:  "ede289367dec550c10696f56bb239b1d06231ffa49369d8a408a0d6112e29c05",
           x86_64_linux: "636bf7a6500c1538fef272627c0c8eb82c75ddeb07f836f845b656e80c18734a"
    "it-IT"
  end
  language "ja" do
    sha256 arm:          "fb53bff105173a49de51918e7b675d569f57172d34fdddb19d5ea0ad8017b4a1",
           intel:        "8d91140a6b59420040c517eee8fc2d965f8cb0f2dbba16abbf15b770e3e27413",
           arm64_linux:  "551d997abfb43844a8ba38d17e1458689361f30adef5f6961b95505ea4f88227",
           x86_64_linux: "a9b8da9590f6e4343d6fc7afd3b3d6a4761552a2b308cd2e7f4308b97ca6f377"
    "ja-JP"
  end
  language "ko" do
    sha256 arm:          "03ca97d72a44aa04e6b2eb383f59a13e0430ee21d2cb4a9611f26c8228d6f439",
           intel:        "ee807d0edfe3fcfa1e61bc5cd526f2d8202bf635370c2074c1cdc2f6fae6b2e9",
           arm64_linux:  "22d2d3972d0e88474049a5824453b7a47e3685f230f37ee00295fb6c92f87311",
           x86_64_linux: "e953e4a52c9b1197ce2aad3bb358d33e54e39e29b708ddb37458f726ae4d7dc2"
    "ko-KR"
  end
  language "pl" do
    sha256 arm:          "b7fad5f12b345071082af5f7ad066ecfee3ae9e0587f8dec18616d7b7171f457",
           intel:        "343bda4bf6d1e0185816c11d4d2087acd0a0e762211a98bfdbb195193ae97bfa",
           arm64_linux:  "10da01825c31e900f2288601bf214bcec5e810642b97e9fd0c304d5f9ee716b9",
           x86_64_linux: "6029177145d24d7f11605ee2c061cad7b80d918a7dd4fb052866b84403d1031f"
    "pl-PL"
  end
  language "pt", "BR" do
    sha256 arm:          "d9cb56fbabc7b3d517cbce6d12c3324c225b7c56061689d0a585a8ecc92f4252",
           intel:        "711b5a8193934fd135d00b1f49a32f55088e2da49ddcb3c8f70433b761956151",
           arm64_linux:  "58ccb46d39b5d7ec10aee03f0f9df17d861e35ab7ddd06769baf5aad20278b63",
           x86_64_linux: "4ffab43e81c6fb9d10a86a41d9a76e791c6399537ba1cbb1271167b571c0eb9b"
    "pt-BR"
  end
  language "ru" do
    sha256 arm:          "b288c1209d430c7946c89e8d7ebda69d7eaa704beb0283004544e0c13816ad07",
           intel:        "665e8810386b5648320a84441473827d4f0f5bd98f732c27d2576d36666fc0a8",
           arm64_linux:  "9f14dc1de7222879e4a611c7d2731890253a6316384ce64d27553abdac3bbff5",
           x86_64_linux: "143800708c1417ecc003f96eeb793dab05f858a22cfd6edce3e943ad94b8122e"
    "ru-RU"
  end
  language "tr" do
    sha256 arm:          "f450b9e028184ec9bb350c2df62c4e7caed7541cc4f395dd2f00c2a49c58c79a",
           intel:        "140d0a318fe6c33d16450c8dd9e4bb32e1373f22cf5bae8b2e723005f6b61ce1",
           arm64_linux:  "637e4dd16fa1f4e99cda84d197421b61f9d9f83ecce72f6a59439d3cf445ace9",
           x86_64_linux: "b37b27123c806d0fc4057ad07c1fdd8b0eebf20e6de0c3d42efe1526eaa96c1c"
    "tr-TR"
  end
  language "zh", "CN", default: true do
    sha256 arm:          "e59c567d071d993fd0aef2de979e1c88cc8f51c71b2770f705e8e3bb93e46c57",
           intel:        "c48de44a8f2f6833ad57ae933b7058af0eb504ebc201cb93e4ef81239f67c8e2",
           arm64_linux:  "46c194969dc06b11dc51814e8ec8a1e0c5e889578e16ce411db5b1d730498541",
           x86_64_linux: "775314822fe3385cdcd18e0a0e66e17038e35f9c68f9020c8da281f7d73d48c0"
    "zh-CN"
  end
  language "zh", "TW" do
    sha256 arm:          "9a8cebef3fd2fc32eb2256b28b7eab006b613e6634bf5322f18a7c8c7418b040",
           intel:        "82aa0ef19dd8a4528868815bda33495af34dd378f4c1957167e1b1c53f28cc94",
           arm64_linux:  "71dfe92e69fcd20849d98bf254cee50ef903d7ab9a09b8817fd9f0dcbc191bab",
           x86_64_linux: "9f582df05b56e09278dcaaff1684fb3af93980e7c3f0b5e314ae8c11c35c46fe"
    "zh-TW"
  end

  # macOS ships "Zed-i18n-<lang>-macos-<arch>.dmg"; Linux ships "zed-i18n-<lang>-linux-<arch>.tar.gz".
  url "https://github.com/LI-NA/zed-i18n/releases/download/v#{version}/" \
      "#{on_macos { "Zed-i18n" } || "zed-i18n"}-#{language}-#{os}-#{arch}." \
      "#{on_macos { "dmg" } || "tar.gz"}"
  name "Zed"
  desc "Localized build of the Zed editor"
  homepage "https://github.com/LI-NA/zed-i18n"

  livecheck do
    url :homepage
    strategy :github_latest
    regex(/v?(\d+\.\d+\.\d+-i18n\.\d+)/i)
  end

  on_macos do
    # The DMG ships as "Zed i18n.app"; install it as "Zed.app" for consistency
    # with the official Zed installation so Spotlight and integrations find it.
    app "Zed i18n.app", target: "Zed.app"
    binary "#{appdir}/Zed.app/Contents/MacOS/cli", target: "zed"

    # Strip debug symbols to shrink the binary on disk (~94 MB smaller).
    # strip invalidates the app's code signature, so we must re-sign.
    # Prefer a local Developer ID certificate (if available) over ad-hoc signing
    # to preserve Keychain access permissions across updates.
    postflight do
      app = "#{appdir}/Zed.app"
      binary = "#{app}/Contents/MacOS/zed"
      cli_binary = "#{app}/Contents/MacOS/cli"
      entitlements = "#{app}/Contents/Resources/zed.entitlements"

      system_command "strip", args: ["-x", binary] if File.exist?(binary)
      system_command "strip", args: ["-x", cli_binary] if File.exist?(cli_binary)

      # Find any code signing certificate; fallback to ad-hoc ("-") if none exists.
      # A fixed certificate preserves Keychain access permissions across updates.
      security_output = system_command("security",
                                       args: ["find-identity", "-v", "-p", "codesigning"]).stdout
      cert_id = security_output.scan(/\(([A-Z0-9]+)\)/).flatten.first || "-"

      if File.exist?(entitlements)
        system_command "codesign",
                       args: ["--force", "--deep", "--sign", cert_id, "--entitlements", entitlements, app]
      else
        system_command "codesign", args: ["--force", "--deep", "--sign", cert_id, app]
      end
    end

    zap trash: [
      "~/Library/Application Support/Zed",
      "~/Library/Caches/Zed",
      "~/Library/Logs/Zed",
      "~/Library/Preferences/dev.zed-i18n.Zed.plist",
      "~/Library/Saved Application State/dev.zed-i18n.Zed.savedState",
    ]
  end

  on_linux do
    binary "zed.app/bin/zed", target: "zed"
  end
end
