cask "faro" do
  version "1.0.0"
  sha256 "8a23af5025691e46578bc2d84942086a66442dfefc81a98738818570b91acba3"

  url "https://github.com/lucasm6195/faro/releases/download/v#{version}/Faro-#{version}.zip"
  name "Faro"
  desc "Terminal nativa pensada para trabajar con Claude Code"
  homepage "https://github.com/lucasm6195/faro"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Faro.app"

  # Faro está firmado pero no notarizado: sin esto macOS no dejaría abrirlo la primera vez.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Faro.app"],
        must_succeed:   false,
        writable_paths: ["Faro.app"],
        writable_base:  :appdir
  end

  zap trash: [
    "~/Library/Application Support/Faro",
    "~/Library/Preferences/dev.faro.terminal.plist",
  ]
end
