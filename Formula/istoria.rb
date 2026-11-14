class Istoria < Formula
  desc "Bash history finder that forgives typos"
  homepage "https://github.com/ivanouski/istoria/"
  url "https://github.com/ivanouski/istoria/archive/refs/tags/v0.42.0.tar.gz"
  sha256 "07849178b4b35afa79e6076a2d8b9cda1bff0a35d0054fd872cf1a0dee9bc25d"
  license "MIT"

  bottle do
    root_url "https://github.com/ivanouski/homebrew-tap/releases/download/istoria-0.42.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "29adab9c5bc55a5f887b946143952d015240012a23db40416c2c84b5616acff8"
    sha256 cellar: :any,                 x86_64_linux: "ba5fb7f594c1bdef5bd4732249f8c81eb0dbb299afb3c77819faac970267c821"
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
