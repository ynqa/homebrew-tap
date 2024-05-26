class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  version "0.2.3"
  on_macos do
    url "https://github.com/ynqa/jnv/releases/download/v0.2.3/jnv-x86_64-apple-darwin.tar.xz"
    sha256 "9c2b3f6b57a4b7ac438414717ffca075537df1e4a1c535dc28f16702e9037cbb"
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/jnv/releases/download/v0.2.3/jnv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "306a055af3b7ea5eb9fbc696deb9196e52d6216c081a0a7db1d42f33fdf8bb05"
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
