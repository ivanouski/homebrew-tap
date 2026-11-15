class Istoria < Formula
  desc "Bash history finder that forgives typos"
  homepage "https://github.com/ivanouski/istoria/"
  url "https://github.com/ivanouski/istoria/archive/refs/tags/v0.43.1.tar.gz"
  sha256 "b2c827bca7db091b2c8d3d4b9023279b236eb9dfee6440780022fa78eea90321"
  license "MIT"

  bottle do
    root_url "https://github.com/ivanouski/homebrew-tap/releases/download/istoria-0.43.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "346a737cd30f475c5df86aebadc75b5b3166f8fca9e4fe9a2d204b4d69bbf5c9"
    sha256 cellar: :any,                 x86_64_linux: "3670f90996a8650714a32cf5c1ee66f8ee092bee37095c3a18df0c43f33aaf00"
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
