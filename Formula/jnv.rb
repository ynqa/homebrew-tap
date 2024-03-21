class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  version "0.1.2"
  on_macos do
    url "https://github.com/ynqa/jnv/releases/download/v0.1.2/jnv-x86_64-apple-darwin.tar.xz"
    sha256 "6c59e4f56794844c608d6cd62bf66bff8194d2d841d2578caf66e43074827e69"
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/jnv/releases/download/v0.1.2/jnv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d281a18c8bd45fb438b70d57619513ec710428aeee625747c19fa61af17743d6"
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
