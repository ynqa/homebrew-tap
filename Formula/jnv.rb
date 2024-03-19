class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  version "0.1.0"
  on_macos do
    url "https://github.com/ynqa/jnv/releases/download/v0.1.0/jnv-x86_64-apple-darwin.tar.xz"
    sha256 "3aeabec8a1b1269166df93e5f6b185f0c3eccb0aee883ae8a7cc12c13e3bd182"
  end
  license "MIT"

  def install
    on_macos do
      on_arm do
        bin.install "jnv"
      end
    end
    on_macos do
      on_intel do
        bin.install "jnv"
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
