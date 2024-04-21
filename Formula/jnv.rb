class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  version "0.2.2"
  on_macos do
    url "https://github.com/ynqa/jnv/releases/download/v0.2.2/jnv-x86_64-apple-darwin.tar.xz"
    sha256 "1ab1562bb085d0f71d2f491f9ae96151f4cc3eaf9511c056ecf522f2d7ce9b15"
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/jnv/releases/download/v0.2.2/jnv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "087f6af17115a0fa0e52b7b91bc7f89b3a3e4b7aa6011447cfaf32a5024edb4a"
    end
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
    on_linux do
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
