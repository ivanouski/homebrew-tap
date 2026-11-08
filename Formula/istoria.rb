class Istoria < Formula
  desc "Bash history finder that forgives typos"
  homepage "https://github.com/ivanouski/istoria/"
  url "https://github.com/ivanouski/istoria/archive/refs/tags/v0.40.0.tar.gz"
  sha256 "d4d885578ebf048d4a74631b9f50076ed5063a612c3a09d743f5904267846453"
  license "MIT"

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
