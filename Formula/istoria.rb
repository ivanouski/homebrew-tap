class Istoria < Formula
  desc "Bash history finder that forgives typos"
  homepage "https://github.com/ivanouski/istoria/"
  url "https://github.com/ivanouski/istoria/archive/refs/tags/v0.46.0.tar.gz"
  sha256 "909c214740cdaddf1750905844c52f778ee74540396bfe985e4b705aa7d6f326"
  license "MIT"

  bottle do
    root_url "https://github.com/ivanouski/homebrew-tap/releases/download/istoria-0.46.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "db440566b6557f22d01321ab54156a1fe02e12a5317fd574a374e08168559a56"
    sha256 cellar: :any,                 x86_64_linux: "3d2799a6504833dcc21441937cb1cb7cbbde37e77d87715013d8480c63581549"
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
