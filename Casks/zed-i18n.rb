cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.10.2-i18n.1"

  language "cs" do
    sha256 arm:          "d59a175d80186ded5f1e87b30ff16a53cf246f6247f8afa5753abc77f78bf7f3",
           intel:        "dc1253f35279753b4ba7e3589a23457632016af4362141080a738017c62bca7d",
           arm64_linux:  "3b66c3b4a47578ff7dbf230742591fdf464d5dfd205dd3df8c9a314fbc6fc009",
           x86_64_linux: "5b17a29ecf55b185b2c3de7d31c1ff87447d24f5545a4dd3febb3d70574da2c1"
    "cs-CZ"
  end
  language "de" do
    sha256 arm:          "28eba751bbc7ee528c1e278c549bac37f354a95bb417e7c640b257f07048209e",
           intel:        "8c3807a998903d1a68c02100779eb3c6883d391fa06d42b9ed9297030eb2aacf",
           arm64_linux:  "6b9a02db376f1ec92a080bfcac3db5e066dd41950351d7e5a07bac94771aaf14",
           x86_64_linux: "a382f33da6ef216dc628f89c2810b829e55dfe0583cdb3b7764a8a70defd0a75"
    "de-DE"
  end
  language "es" do
    sha256 arm:          "f0a7473debb2a364bcf96916a6c05e275c79612414371923998f33f63f923ae0",
           intel:        "610b0cb66d486bb772e38832fbd777c0217fd6583d4ba10b632c006712f5cbec",
           arm64_linux:  "4edb99034c82b8b4b8dbf73305a16fa7880e9a9879651429051016731d19d489",
           x86_64_linux: "51ba64549fc575f2562530cef50d4d9e31dd9e88fe2de5051099ca63b1d7c0f0"
    "es-ES"
  end
  language "fr" do
    sha256 arm:          "dd4c0de7cda15ccd8e6e13e98edec2329b6f138c164d5f9708498e3bb94e4c8c",
           intel:        "6230bc8aa587da95a3a5a840a8fe69ab60e887d3967be8d1c4a567213e8e192c",
           arm64_linux:  "746993fca1eebf45a996e8eef05dd187f6c9a71e96f869099c39846e9c160e2e",
           x86_64_linux: "a0491ef2ca782e7b979f30a443a1e9ce5d3e46d2762d087f5000d656917d1941"
    "fr-FR"
  end
  language "it" do
    sha256 arm:          "4e76082f8ab4b294e9ca2bb96b79b0f0d5621170ce31963b8f48c71fab299ddb",
           intel:        "d7377831cd402f0bbbccf7d787e2a2538e4e876817f38924f0c01b0ead28d008",
           arm64_linux:  "ccf44acc9e1550ae4b10657256a2242c2a0287af4be2df54745a8cabf83dedac",
           x86_64_linux: "22b6684398ecdaf474da293a7bfab5206715ec3d78b0a803ac2b6ae8acfba1c8"
    "it-IT"
  end
  language "ja" do
    sha256 arm:          "459c5cd2c2deb80d4020b9c0938d85374d8bb97bc744650879cd7739630af48b",
           intel:        "d43caffaa28a5ad24fb15ab84e1a407775a637f4e5d9e82367691dcdd84e07f9",
           arm64_linux:  "83f65df8f88fa2e3b583cdae773c4bfc0bea36e24ebae0b804dfad52d8df257b",
           x86_64_linux: "2bc7e6296d39e409cfaf430436f93f52c32be344f2253cf7555091ee49fb527b"
    "ja-JP"
  end
  language "ko" do
    sha256 arm:          "cf8f7aa5f107b96be118edc9ad085d3826b623049592dbdb60a84953961f7422",
           intel:        "ea147654084f8ca1d92d5b4cc93b01a5c6c01c0bc6432edae22dd3b5a6062bb2",
           arm64_linux:  "872c21fe6daf6467c8abc52d6c3a960ec3f4f852a537b3878fde62a53f476fec",
           x86_64_linux: "fa85f1d8ce91b8b4269f7eebe401525961cf47a0d51999ab829a15447add2eaa"
    "ko-KR"
  end
  language "pl" do
    sha256 arm:          "b3699ca06b49f3fbb1d91e62f28253c9c812fcd528f2abe8552c74ea2ce1b369",
           intel:        "627884409a372d7f9a29d48db5d17caf2b35e37dff9926bc403d7ae03536f97b",
           arm64_linux:  "3dbdd4ba561d6dfa4f1fd7d756fcdcf4a9b74a33dcc415bd181908b6a2f30c80",
           x86_64_linux: "f2a154544370ace6bd92cd35b504399ed2c088fd1ac3fdcfc478509347675268"
    "pl-PL"
  end
  language "pt", "BR" do
    sha256 arm:          "ad72c96464aed14f736a72afd67ad33aca13dfb67dd83aedb3ef1a275b78303e",
           intel:        "5926b011618dd8b265a58e57a67d7172e0a7b845480305017f3cbd283411ed41",
           arm64_linux:  "ba58620ee98ce702c9bf0cba468509e597726a2bc44adddb43b0b5c166e7f165",
           x86_64_linux: "c019b2df3376b9293b5057496429b3ad43387feca3249e3dac249a2c0ec1a3c7"
    "pt-BR"
  end
  language "ru" do
    sha256 arm:          "eb5300383ff7c7fc4d108d5277931134d7ec5cc4f557a1db3f7d6aa4788b736b",
           intel:        "1972dc5e737bbb20d8eaf4092bbf3601b67283d03e744e5193034fe3f59f68db",
           arm64_linux:  "b9922815bdd98f505dc0eb131122548170a06af90a59c66e8f25dfdbbed657d9",
           x86_64_linux: "98cf7d89029018fbc03b567bff94bf4d08a6db4370aa32da50e01c3a656e6042"
    "ru-RU"
  end
  language "tr" do
    sha256 arm:          "9014faec0aa2623851c9620ea5a3efbb0a271e6b95f1f391215bb47dc4e4e9b7",
           intel:        "cbf0480362d2bbe5246d173e3b59bb314373a20037b65b2fcb9d5fbc53d5a054",
           arm64_linux:  "f714bc1ce6e4677640158b4c9d9403362871bd48393fdff2117582ddcf481e33",
           x86_64_linux: "0835c7462eccd5f47b97b2e3aeddfe4ae00ddcdfe43ca1b402c154badbd7e11b"
    "tr-TR"
  end
  language "zh", "CN", default: true do
    sha256 arm:          "59c289e6330743ad65ba11c7cb10089dc05608d3752eda611a6acc13fc4b994a",
           intel:        "deb645fa45b461fc1bada9ee875843e48f1240167ae04e7a3ecba7e46f487042",
           arm64_linux:  "86d3811b63bf8c4bbce1f1552fc449fcc087991de256a5e83ee7fe5db037c783",
           x86_64_linux: "7bf181532f97d0ca510fa5feb18eecee98511f1485e45b38c18a776d5a6c6358"
    "zh-CN"
  end
  language "zh", "TW" do
    sha256 arm:          "186072821e619650962e73b0ac55099332f4f8e50cf9ecdeede4c7057bc9070d",
           intel:        "c89e17aa8261cd8bdc2a55aa03f817c88c059a9b36ae09da8bd1da14b8942e16",
           arm64_linux:  "79dc2926a7308b4e5f6d23dc2d9855e908f7241b4621e777a5a1bbf65a7f34d9",
           x86_64_linux: "068ea14a7312778f19a299401fdc495f062ed3b964b29f8a26798a515ab9bcbc"
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
