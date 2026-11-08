class Box < Formula
  desc "Lists, prunes and stops docker containers, images and volumes, with a dashboard"
  homepage "https://github.com/mafflin/box/"
  url "https://github.com/mafflin/box/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "dccb80fbb62007ee63a0f6fce514c354da59fb3a9a9c6eb8c8417a4f0d0e730b"
  license "MIT"

  bottle do
    root_url "https://github.com/ivanouski/homebrew-tap/releases/download/box-0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e5e9aae2fb9b599fb81e20a301faff484d0f3d2ab398c3d47fc4a92a6d8dcb20"
    sha256 cellar: :any,                 x86_64_linux: "d9c438ff5e6b281b8fccf79534dba3bc4ac6a9a3bd2b0c6ef89e81b610887849"
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
