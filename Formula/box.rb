class Box < Formula
  desc "Lists, prunes and stops docker containers, images and volumes, with a dashboard"
  homepage "https://github.com/mafflin/box/"
  url "https://github.com/mafflin/box/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "eddc2d27508e871615953c6d56241bea659e1d5752d1d2d9194cd1e090c1ee5a"
  license "MIT"

  bottle do
    root_url "https://github.com/ivanouski/homebrew-tap/releases/download/box-0.4.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "3e0c277b5a1c857222e0b9591a8cc841f8e4c5e811ca4603270690f2b14c51b4"
    sha256 cellar: :any,                 x86_64_linux: "c11fa9e28e45f4a91636c9de22fbe3a11f266cc750bc41b79319a91091b31e75"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    bash_completion.install "completions/bash/_box" => "box"
    zsh_completion.install "completions/zsh/_box"
  end

  test do
    assert_match "box #{version}", shell_output("#{bin}/box --version")
  end
end
