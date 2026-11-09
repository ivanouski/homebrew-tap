class Istoria < Formula
  desc "Bash history finder that forgives typos"
  homepage "https://github.com/ivanouski/istoria/"
  url "https://github.com/ivanouski/istoria/archive/refs/tags/v0.41.0.tar.gz"
  sha256 "06eb1267b78f019c3320e3571585dc6dd01245483986a7cd88e1bffdc5f42750"
  license "MIT"

  bottle do
    root_url "https://github.com/ivanouski/homebrew-tap/releases/download/istoria-0.41.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "59cddb01c1c2797b15ba388aeb02124a9dd1caea7b498ede1a340a2d198f1aa0"
    sha256 cellar: :any,                 x86_64_linux: "0636b7a979ab3000ed60146d6435595ce629ec8c513c071f3a4ea3064288a0f5"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    # Sourced from here rather than copied, so each upgrade brings the istoriarc that matches istoria
    pkgshare.install "home/.istoriarc" => "istoriarc"
    bash_completion.install "completions/_istoria" => "istoria"
  end

  def caveats
    <<~EOS
      To bind istoria to your keys, add this to ~/.bashrc:
        [[ -f #{opt_pkgshare}/istoriarc ]] && . #{opt_pkgshare}/istoriarc
      It needs bash 4.0 or later; macOS ships 3.2, see `brew install bash`.
    EOS
  end

  test do
    assert_match "istoria #{version}", shell_output("#{bin}/istoria --version")
  end
end
