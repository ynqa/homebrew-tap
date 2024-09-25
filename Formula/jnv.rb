class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  version "0.4.1"
  on_macos do
    on_arm do
      url "https://github.com/ynqa/jnv/releases/download/v0.4.1/jnv-aarch64-apple-darwin.tar.xz"
      sha256 "521ab5cce6853cb73c0b634404c11e83ffeec711dfca8bc8b27f548080def285"
    end
    on_intel do
      url "https://github.com/ynqa/jnv/releases/download/v0.4.1/jnv-x86_64-apple-darwin.tar.xz"
      sha256 "11b7824ed7ed78abfda3f39b2583fde718bdfb50f2db1100014bf1064627da9f"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/jnv/releases/download/v0.4.1/jnv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "82df03d2121c23609f54e8f11a3d48809768c9cfbd0a59c247a4447efe160ae4"
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
