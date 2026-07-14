cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.10.3-i18n.1"

  language "cs" do
    sha256 arm:          "b5ec905bf0bd195018c6986a56cc46e995d7d5c5e5af74439b9d2288adb0e6ae",
           intel:        "08b3ee564bd8f818e9043dca85ef5322e20a10e9a5688eb12ef209310c47d842",
           arm64_linux:  "61e45f72149996b0ead2d3051a374878006614bdc9e1f52328819e298eb2c50a",
           x86_64_linux: "1d4100bac3703986b59e40aeab34c6dac17273855b7054b6e360b8f97152f95d"
    "cs-CZ"
  end
  language "de" do
    sha256 arm:          "9e495256313e10ce3c3ed830ef1b11cbaaf0f538b54fcb16dd205eac0864d3d2",
           intel:        "097fdd5e08a7e88041125c7d112492b86cc6136297ed57d1463dba43cc2d7245",
           arm64_linux:  "b767549183f4f42e0fd3a8141f6def88971d5812c09f51882a710335640d4ff8",
           x86_64_linux: "1e8c9cf25f3447d3725091bba74fd50ff67d2553634638081829506ad0cc25cb"
    "de-DE"
  end
  language "es" do
    sha256 arm:          "9f04cb61f43a2dee15864c2a80087d04c1ef7b41575ea13dc57fcdfad6388efe",
           intel:        "148387df7666bf73b55603d6da1798b53460f3893f384c90add37168aea97d36",
           arm64_linux:  "9451a1bcbdb727af1a12a9d2dd86c605b2e8b94a17e9cb99cb7ad45703996bc9",
           x86_64_linux: "425e6c2533bbec4100d37d0b369f250688c04d393a09ece34eee58431d8b18fa"
    "es-ES"
  end
  language "fr" do
    sha256 arm:          "deb30442df26031a1810265fd147f7cbf9020ca9b078b80173e03887b4dcfafd",
           intel:        "933f74be1cc952b26e9421efe7a5d11d466661cd9de95ac7b7fe971ddfb61c6c",
           arm64_linux:  "f100259720e5769622cba6ec3d9893e1f53700dfe5ba3019006550087685d52f",
           x86_64_linux: "4056e3527984fad9b2f81ef7f49aa80c8d4d4b025f098a41f9e0107808897248"
    "fr-FR"
  end
  language "it" do
    sha256 arm:          "50d72b857f06915d14a87ad47aa38e3de7d97c2516b8f35d08677b74c434b9b4",
           intel:        "9166057d7fd8f404884eee0704a4ca71ebdee5d7466095dc2d201d11382d4ea3",
           arm64_linux:  "85bed4154116c2cd0fc39ad634031dde34ac8baed82714eba29114c5bd7bc50e",
           x86_64_linux: "dad5d7a460e25165ea6cacfc64e71c3088f56ad6325fb4465d481044a517580d"
    "it-IT"
  end
  language "ja" do
    sha256 arm:          "6d64d72c1111d72cf0b2f2fe6e03295fc5c686462afa045edf531dc03dd93d78",
           intel:        "2532fd874b35f734dd0b10db1890f2ad42d74079b6b7215993a146b34b4ac568",
           arm64_linux:  "2ec5718044fc673c8863300db2ed915975dc1a8173dc3166578f14f73f7c4289",
           x86_64_linux: "f4d1a3f054139cfd5e153a195fbeea735238739a1486734c89ee97c7eb42576f"
    "ja-JP"
  end
  language "ko" do
    sha256 arm:          "e9731e6b340d6b5b2583297c02b0c7d735e82c4fb321c2e05c392f154251c374",
           intel:        "45023a3214481f25facb5e62950f1624985dcc24115adc0a1af0fa4adc0c6e32",
           arm64_linux:  "c585de7f18275658ec793fcdfcaa3dba9bfb6fccfe05ad91fb898d826b7e1a3c",
           x86_64_linux: "76372a2ae43edf16fb4db816cb30dece986c33248caa4760e8c1212eee3f23d3"
    "ko-KR"
  end
  language "pl" do
    sha256 arm:          "0f57c959760cdd11f0b6601099ef4e152d40baf21d9e6d7c8d5ee6cc829be1d4",
           intel:        "13b4f4b56af6dbe230f357ed3e281d2ff1931e41384b16d3f4ad01322457d76b",
           arm64_linux:  "46ae1a261ced9a8719a50f4fafb6f6d97e9d2dbd86b4da2ce9c0e3c19f344f84",
           x86_64_linux: "df8d2dd44eb7cf1e01e95af396b3827ef0c0865b64092a2f699cd016437ad771"
    "pl-PL"
  end
  language "pt", "BR" do
    sha256 arm:          "ea8bf9f497333364045da7a59dfb001b5c31a95244d6caf89ae8c0ef140331bd",
           intel:        "5f7ff0583948472f1ffb72bc3401e9677303a13a944cdc39a13891551262ad6c",
           arm64_linux:  "4ee3549f85ba736326c4b48523954c548c7dc4e77bd782ba34423d148c7dcb44",
           x86_64_linux: "81d43e99a1583eb07bba8b6d299d5530aeef7e4201442775b4dc7bf452edb1c0"
    "pt-BR"
  end
  language "ru" do
    sha256 arm:          "e761ec51217413c047828cd01b3c56fb3022510e78c23d0ecefb1b470b4f7e8a",
           intel:        "a04d2e5e6a5d39133ae9ea6ae61cd61d684e9fe7ccd6d1bf4b8b07d1eb2735ee",
           arm64_linux:  "f90456b21bf110b3dfbac967144a7e79936483ca69d8e554605ba576c9736a2d",
           x86_64_linux: "8c8b3dc0b36d4144b95cdf26871f8e6179486083cfa3fe1c8c50218ff658c76e"
    "ru-RU"
  end
  language "tr" do
    sha256 arm:          "c9821b5dcaab014fb06c2b55636ded5f2acbef234e230dbb2dc75e959be52d25",
           intel:        "d7e06a267581c4b215fe3080d2eb088b51a26c156e6d8a2d3e075758b6fa1c41",
           arm64_linux:  "3a964d6804b374b7623783b4d53acc955a4f651b18cb178a8433cce9069bf270",
           x86_64_linux: "ce4ea66d9d646c60a583fb3c8e1dd2e8982cc23bec343d100d260b831f7cf7fa"
    "tr-TR"
  end
  language "zh", "CN", default: true do
    sha256 arm:          "045f42cbb6195c3ef2e217c279728d1db152fee6f64c9870cec144c93d2a79e6",
           intel:        "39d6a769b97b29712db15f82460d7533bc93833561d1c286e72288205563cb84",
           arm64_linux:  "44fa94613da91c4d11331ff1550decc05b9087113a7ee73938c0e1c260041aa6",
           x86_64_linux: "c8f0b2f078db99474368f0fffac64ce55eaff9fe1c3c651aa8a003ba649225be"
    "zh-CN"
  end
  language "zh", "TW" do
    sha256 arm:          "403fa7b2c80b38e435521fc5fc3d666b2c4216fd1660365a0d0629557e8d6505",
           intel:        "5a610c5fc0bd70e8e414a1ddc570f62d868721dee72a37b30c5c86a4039192fa",
           arm64_linux:  "24afd9fd10c54c42134fed765120cb6d70e204d02aa7719bea1946e775f29978",
           x86_64_linux: "c1328d7cb323ad910455dc17966598429bc250091a37edeeee5f7b54225a36d7"
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
