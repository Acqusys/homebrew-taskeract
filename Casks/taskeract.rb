cask "taskeract" do
  version "2.3.14"
  sha256 "a8f58136eba9430b5273bda971d0a42e18111f7800ca6fcba0467ce378a87023"

  url "https://f001.backblazeb2.com/file/taskeract-pub/releases/v#{version}/Taskeract_#{version}_aarch64.dmg"
  name "Taskeract"
  desc "Desktop app for orchestrating AI coding agents"
  homepage "https://taskeract.dev/"

  depends_on arch: :arm64
  depends_on formula: "nss"
  depends_on :macos

  app "Taskeract.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/Taskeract.app"]
  end

  zap trash: [
    "~/Library/Application Support/dev.taskeract.app",
    "~/Library/Caches/dev.taskeract.app",
    "~/Library/Preferences/dev.taskeract.app.plist",
    "~/Library/Saved Application State/dev.taskeract.app.savedState",
  ]

  caveats <<~EOS
    Taskeract is not yet notarized with Apple. If macOS reports the app
    as damaged, the quarantine attribute may need to be cleared manually:

      xattr -cr #{appdir}/Taskeract.app
  EOS
end
