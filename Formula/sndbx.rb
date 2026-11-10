class Sndbx < Formula
  desc "Small wrapper around docker run for running coding agents in a sandbox"
  homepage "https://github.com/ivanouski/sndbx/"
  url "https://github.com/ivanouski/sndbx/archive/refs/tags/v0.45.2.tar.gz"
  sha256 "22d606c959db01fa1964526b9cb3685b32d3a023b5943fe3d3a859abc7a57936"
  license "MIT"

  bottle do
    root_url "https://github.com/ivanouski/homebrew-tap/releases/download/sndbx-0.45.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "88e58ccae682e378cbf482b5dd5b4b1e2ac38a8faf37083fc688d4afde3b41ae"
    sha256 cellar: :any,                 x86_64_linux: "7674fad225088170e1aa448c834bcb7007c8f5711694dec2cd36a873d75d4354"
  end

  depends_on "rust" => :build

  def install
    pkgshare.install "images"
    # Where sndbx build finds images without an images_dir setting; opt_pkgshare stays put across upgrades
    ENV["SNDBX_IMAGES_DIR"] = opt_pkgshare/"images"
    system "cargo", "install", *std_cargo_args
    bash_completion.install "completions/bash/_sndbx"
    zsh_completion.install "completions/zsh/_sndbx"
  end

  def caveats
    <<~EOS
      sndbx runs docker, e.g. from Docker Desktop, OrbStack or Colima.
      For images of your own, set images_dir in ~/.config/sndbx/settings.yml:
      brew replaces #{opt_pkgshare}/images on every upgrade.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sndbx --version")
  end
end
