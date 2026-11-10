class Sndbx < Formula
  desc "Small wrapper around docker run for running coding agents in a sandbox"
  homepage "https://github.com/ivanouski/sndbx/"
  url "https://github.com/ivanouski/sndbx/archive/refs/tags/v0.45.1.tar.gz"
  sha256 "bd8464a79be371752415be603aef067da8590aceefcff83c9b69444f733c3946"
  license "MIT"

  bottle do
    root_url "https://github.com/ivanouski/homebrew-tap/releases/download/sndbx-0.45.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "1ef2a9fab27f7f9718a97c87d2a56ab8ddbd80bae24ba41464577453124b1dd4"
    sha256 cellar: :any,                 x86_64_linux: "bec4e84443beb7d3066f3cdd3471a9cbee70a2867196e65015efe603b248ba90"
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
