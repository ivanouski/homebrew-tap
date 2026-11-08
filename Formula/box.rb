class Box < Formula
  desc "Lists, prunes and stops docker containers, images and volumes, with a dashboard"
  homepage "https://github.com/mafflin/box/"
  url "https://github.com/mafflin/box/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "dccb80fbb62007ee63a0f6fce514c354da59fb3a9a9c6eb8c8417a4f0d0e730b"
  license "MIT"

  bottle do
    root_url "https://github.com/ivanouski/homebrew-tap/releases/download/box-0.4.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8412bfbcce56536547dd5b201cfa473e83c76321d8d36e155e833217b2c794ee"
    sha256 cellar: :any,                 x86_64_linux: "e28b675da173fc183fd1465cf7dedd07faa578bd3b8dbdc66b735d7df636d1c6"
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
