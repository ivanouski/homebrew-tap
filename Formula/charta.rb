class Charta < Formula
  desc "Tiny, lightweight CLI for quick notes, kept in a git repo"
  homepage "https://github.com/mafflin/charta/"
  url "https://github.com/mafflin/charta/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "37b50e7bc9b6380b42c89b8b31590f5439271dd69f3e5726bb00e2ee0337bcba"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    bash_completion.install "completions/bash/_charta" => "charta"
    zsh_completion.install "completions/zsh/_charta"
  end

  test do
    assert_match "charta #{version}", shell_output("#{bin}/charta --version")
  end
end
