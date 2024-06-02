class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  version "0.3.0"
  on_macos do
    on_arm do
      url "https://github.com/ynqa/jnv/releases/download/v0.3.0/jnv-aarch64-apple-darwin.tar.xz"
      sha256 "1036c29eeb7172c28d543ee4d90fa1c82303e5ee47070f56de6a7c6190faa7a9"
    end
    on_intel do
      url "https://github.com/ynqa/jnv/releases/download/v0.3.0/jnv-x86_64-apple-darwin.tar.xz"
      sha256 "19444daa6060af9eedaf141c7ceb2ebde8dafec382558c648321cb3face673c8"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/jnv/releases/download/v0.3.0/jnv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1755327720b84189a4a8e718ef5a8c22ea3d6308d38e24c7e80a085a398b96a2"
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
