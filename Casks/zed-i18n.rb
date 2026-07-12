cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"
  version "1.9.0-i18n.1"

  language "cs" do
    sha256 arm:          "2ddab30a05363a17596b610e81c36026e680c6e48bb83131a062e4977ac01144",
           intel:        "0683bcd4fd319148b3bf4307b929966e132e25558913e3a2ea54f8db127b56b5",
           arm64_linux:  "8358262947fc357f7b2dffdf483db5a6c1ae1754a5b02ab59b02ecafbb890358",
           x86_64_linux: "84800c4c747a8d5127a99cba5e2b4f236ef1be12a194b71ac9fe7c86d6af9392"
    "cs-CZ"
  end
  language "de" do
    sha256 arm:          "42e331be9b3bf8e5f3abc2f40146e8e49a22eb8e8bf2f419d9358b49572bc008",
           intel:        "6cbc86fc9138570e9df3427a28a941c7eeab0217985991c3a472c892fe0a7088",
           arm64_linux:  "8379e63f2944f96cbf83487b282cbe516ae1cac7852f274cc06eb18ad166d84b",
           x86_64_linux: "c962db44dd97f409a689c6bd88342b0ee17b0f2dd229fd513c8531c115c1b0e1"
    "de-DE"
  end
  language "es" do
    sha256 arm:          "885dfb31acc8b38094a38a91183d6cc19f673c24ca562f6e276203ca3490d326",
           intel:        "013b933b1f834e7ae1f674754fdb2bf0459cce9712130521d00152227ece7807",
           arm64_linux:  "dfb7520919e82f72c115b398a2b94eccf3d1939c97975d359b2bf352f690fc94",
           x86_64_linux: "7eaca27c538e4e1475783b8f609d2b35603045fbf042374755fafbf54f5b9c47"
    "es-ES"
  end
  language "fr" do
    sha256 arm:          "fcc7114e0ae21deab3370454f61f22662d5459ce34b501e82f7af7e85ce7bb4c",
           intel:        "97016311bd4d0e282ec1c0ef293748217aba7790d04938c57484d965120141b9",
           arm64_linux:  "a914376d4b286315cd9d300652a0ca47bb46d98435b12d027fe5f9c81ba88b9f",
           x86_64_linux: "5a6703d73a10d694a9fb2a490c44e77425d70e85aef48fa97f923d048818e73c"
    "fr-FR"
  end
  language "it" do
    sha256 arm:          "09101db9e314a66b589f30bf4f65b3c8e9f336a9da99c4ac3e5621949acc7506",
           intel:        "3f8e6ce982e8de457bddc53ac56d989351ed5928e60a4ccd81af126d13f1e88d",
           arm64_linux:  "d150351e79c0c43d2a817367287c747b31498a7ad7458f8b3a24e43de3c2b779",
           x86_64_linux: "a14f653a51e2ae358265ddae621eac958b502c4b6e3745b7c7e47c20efd58829"
    "it-IT"
  end
  language "ja" do
    sha256 arm:          "919e37b73a93a377ce698cece45356a555cc84fe7cd0211ea84edf74efcdcb06",
           intel:        "e823526dcc36e32345e309419cbdcd6de36f9234ec473a9f96b8607a64898179",
           arm64_linux:  "e26a463353036141962eb03f2e750ac0f861ae6f6ea971487e86f288050d2aee",
           x86_64_linux: "141282c04e1e0d112364adc1af51c2be426b786155f94b762ae661295f3f9c62"
    "ja-JP"
  end
  language "ko" do
    sha256 arm:          "b4e5772d4792d9d0334038f65d8f680681030d48c2ce74d39a62f46e308cc0f7",
           intel:        "2158a0804a0740f055555bba7c31a953913731d3236f59adc80fa4f36c7d31ea",
           arm64_linux:  "c6a037e2415ee05f1aa5cd56c2f9628a3b4e5805672b01571f6ba343526a8b0e",
           x86_64_linux: "bf981b37bd068442a99f3b011a232f56fee122dc2e55034f6ca4ec1df4c6ed8a"
    "ko-KR"
  end
  language "pl" do
    sha256 arm:          "c5f818af4a637ae448fd89e191f23db0334ae3017f3b7bb56f35cd5b2e8edee9",
           intel:        "9203e418d819e8a3399f9ee1cf397ae9fba7ed4258998f380fa5b050827f044f",
           arm64_linux:  "ea95ed2019de3e047a3f119954a645337e678c88844dfc9bdb320ce0726f7c56",
           x86_64_linux: "775b87955dcb3385623b8c993b61b97aaf14ac05fea5ffa282750b332f2c9e6d"
    "pl-PL"
  end
  language "pt", "BR" do
    sha256 arm:          "79ab252fb600c7db6746bdd74abe848ca58675576748c6809a06f9a519b29270",
           intel:        "3fbd4cee3441f750d9d51475d856d7dd43788f96ad717b4da0cbb23d01d75aa3",
           arm64_linux:  "673fd1f96e97dae34697fa9a98c845b2a9813d53ffb2c8b19ad15c5c515c251c",
           x86_64_linux: "8d15619fb71ed2dd65be465dd1264d9c09e0d2ba61254baace11ea277344d040"
    "pt-BR"
  end
  language "ru" do
    sha256 arm:          "c505011c3ae6150bc8ba554f34c3ae8d486d1229e70725efd92777491e487072",
           intel:        "209e0a767d4d08425573802df8bbb5dc05e379f93aecb8c50281620ffc239d20",
           arm64_linux:  "a4335b5c5dc5cf2794e67deda08e2d1a9602efcb8b115b56e7a4771174473495",
           x86_64_linux: "cf178bd0a402685fcabe52cde4ce23399922e1bb6f1556de3a82ee625e034726"
    "ru-RU"
  end
  language "tr" do
    sha256 arm:          "71d8315e153b01dd75cca8a394ebaa588037df5bb985ab09179ffc9d5bcdbe8b",
           intel:        "6bf87bbe4bd6b7bee0c681f2bb771fd9a3c68651a377efbcb5911ca3168ee62a",
           arm64_linux:  "63a6b6d4307921ea4e767f5e34864bf2fa1cea204ca08958cd221097beba9794",
           x86_64_linux: "1221816482fb8efa2036de27a4c54b00bc6aa31758ee82cd8f55b07c450968b0"
    "tr-TR"
  end
  language "zh", "CN", default: true do
    sha256 arm:          "3b63259b5b25f1010af2b4d0aa97c2e57068a0472aaa6c87b224d0ff0958e7b5",
           intel:        "f5ecf8aa302c52018905a934228121fb1747264b8dd3ec49b735e43924d701b2",
           arm64_linux:  "ba7f3fc25aeb6cc4d8e7c04f6df32a0482ccb17a47450481af6a802575bdc498",
           x86_64_linux: "45223a6c5b43a398f9b0fc0e6f699324b046df79daadbd99c952192244c3bbbb"
    "zh-CN"
  end
  language "zh", "TW" do
    sha256 arm:          "d42ba2a579e2a4148b0aafc23f6c1c48eb340792a137c8b8191ccb0226acb7bb",
           intel:        "388a726db21fd1d10062bd2ee48adf07f2020f9dd6bf7eb058d438c43b77cee3",
           arm64_linux:  "4f2233f412c8cf8c666c871485386c4c892d1c639f45a568a7d9113130b28bee",
           x86_64_linux: "55163ffb25ac1f45f3b3690b25969cc85e10fcbd55cce87bd4a46c974bdafc87"
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

    # Strip debug symbols to shrink the binary on disk (mirrors zed-globalization's
    # packaging, ~94 MB smaller). strip invalidates the app's code signature, so
    # re-sign the bundle ad-hoc afterwards — otherwise macOS refuses to launch it.
    postflight do
      app = "#{appdir}/Zed.app"
      binary = "#{app}/Contents/MacOS/zed"
      cli_binary = "#{app}/Contents/MacOS/cli"
      entitlements = "#{app}/Contents/Resources/zed.entitlements"

      system_command "strip", args: ["-x", binary] if File.exist?(binary)
      system_command "strip", args: ["-x", cli_binary] if File.exist?(cli_binary)

      if File.exist?(entitlements)
        system_command "codesign",
                       args: ["--force", "--deep", "--sign", "-", "--entitlements", entitlements, app]
      else
        system_command "codesign", args: ["--force", "--deep", "--sign", "-", app]
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
