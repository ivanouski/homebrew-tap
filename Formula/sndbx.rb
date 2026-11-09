class Sndbx < Formula
  desc "Small wrapper around docker run for running coding agents in a sandbox"
  homepage "https://github.com/ivanouski/sndbx/"
  url "https://github.com/ivanouski/sndbx/archive/refs/tags/v0.44.0.tar.gz"
  sha256 "781150d35b5403b13bf9e38d6759446e78ecfab21b24f642846d82b31d0a97b5"
  license "MIT"

  bottle do
    root_url "https://github.com/ivanouski/homebrew-tap/releases/download/sndbx-0.43.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2c00f506ddccc1bce2316aae2f96910bf6bf7d6e4781780e9ab5877987b683c7"
    sha256 cellar: :any,                 x86_64_linux: "6691cde1c5fd6ef6f10f80197aea3c9269357cc478cbca08c1d2f5a762782d54"
  end

  depends_on "rust" => :build

  def install
    pkgshare.install "images"
    # Where sndbx build finds images without an images_dir setting; opt_pkgshare stays put across upgrades
    ENV["SNDBX_IMAGES_DIR"] = opt_pkgshare/"images"
    system "cargo", "install", *std_cargo_args
    bash_completion.install "completions/bash/sndbx"
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
