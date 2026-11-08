class Box < Formula
  desc "Lists, prunes and stops docker containers, images and volumes, with a dashboard"
  homepage "https://github.com/mafflin/box/"
  url "https://github.com/mafflin/box/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "372345780c2b3f05241922ed73818d7e3e1c001fc40c5be9490b11ae99feb4dc"
  license "MIT"

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
