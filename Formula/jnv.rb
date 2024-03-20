class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  version "0.1.1"
  on_macos do
    url "https://github.com/ynqa/jnv/releases/download/v0.1.1/jnv-x86_64-apple-darwin.tar.xz"
    sha256 "bc2fd4037938a8a8f7bcc821ae48056396b40ef3154c9ded3a106d0b2949fa3c"
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/jnv/releases/download/v0.1.1/jnv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d2ac4265a0d8a4f88301681d370df5e3879a51b9042313800835b6daf5cad95e"
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
