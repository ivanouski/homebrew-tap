class Sndbx < Formula
  desc "Small wrapper around docker run for running coding agents in a sandbox"
  homepage "https://github.com/ivanouski/sndbx/"
  url "https://github.com/ivanouski/sndbx/archive/refs/tags/v0.47.0.tar.gz"
  sha256 "5d5dcb81fad59d2f074b6922024b158ccee89ae4679d7607d38d3a99eaefe60d"
  license "MIT"

  bottle do
    root_url "https://github.com/ivanouski/homebrew-tap/releases/download/sndbx-0.47.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a273eee00928d27a3dbcf7835f70177554785a592cf8e7f7e907263b8db9d9fb"
    sha256 cellar: :any,                 x86_64_linux: "643f62328c6a54866c9c55f5a5b7c60a6a201ee3c7a2be64d7f5d02c5806054d"
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
