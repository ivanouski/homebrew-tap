class Istoria < Formula
  desc "Bash history finder that forgives typos"
  homepage "https://github.com/ivanouski/istoria/"
  url "https://github.com/ivanouski/istoria/archive/refs/tags/v0.41.0.tar.gz"
  sha256 "06eb1267b78f019c3320e3571585dc6dd01245483986a7cd88e1bffdc5f42750"
  license "MIT"

  bottle do
    root_url "https://github.com/ivanouski/homebrew-tap/releases/download/istoria-0.40.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "24efdd8a750507579647ec1cd2548eafb8b95d1a9116b38ea3f640097d432967"
    sha256 cellar: :any,                 x86_64_linux: "29a6dbfa1e25200911c56b17659187945c23d84e3048bb26069ab8034ad30cb0"
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
