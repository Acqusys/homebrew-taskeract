cask "taskeract" do
  version "1.5.0"
  sha256 "4b630f01039562d565ca56dd2d5ba8741656452eea4e702b556ea0630d2e375e"

  url "https://f001.backblazeb2.com/file/taskeract-pub/releases/v#{version}/Taskeract_#{version}_aarch64.dmg"
  name "Taskeract"
  desc "Desktop app for orchestrating AI coding agents"
  homepage "https://taskeract.dev"

  depends_on arch: :arm64

  app "Taskeract.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Taskeract.app"]
  end

  caveats <<~EOS
    Taskeract is not yet notarized with Apple. If macOS reports the app
    as damaged, the quarantine attribute may need to be cleared manually:

      xattr -cr #{appdir}/Taskeract.app
  EOS

  zap trash: [
    "~/Library/Application Support/dev.taskeract.app",
    "~/Library/Caches/dev.taskeract.app",
    "~/Library/Preferences/dev.taskeract.app.plist",
    "~/Library/Saved Application State/dev.taskeract.app.savedState",
  ]
end
