class Istoria < Formula
  desc "Bash history finder that forgives typos"
  homepage "https://github.com/ivanouski/istoria/"
  url "https://github.com/ivanouski/istoria/archive/refs/tags/v0.46.0.tar.gz"
  sha256 "909c214740cdaddf1750905844c52f778ee74540396bfe985e4b705aa7d6f326"
  license "MIT"

  bottle do
    root_url "https://github.com/ivanouski/homebrew-tap/releases/download/istoria-0.44.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "09cbb19d161045f15abeb6fd41437ce65307b316eb9b450ad9dcf95d3b69f5cb"
    sha256 cellar: :any,                 x86_64_linux: "b46ac107a5f8e6fc5d38c58ab77794d8f2f8b24a565844360c955831ad57ee0c"
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
