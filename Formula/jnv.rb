class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  version "0.1.3"
  on_macos do
    url "https://github.com/ynqa/jnv/releases/download/v0.1.3/jnv-x86_64-apple-darwin.tar.xz"
    sha256 "b8793f95dd2fc09931a27644662cb8a6392355a95944dd82d8c8ef848316706e"
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/jnv/releases/download/v0.1.3/jnv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ea209788618b1eaa5be07f804fb3df4bdc1d2739c0c6122031112985ab1590ac"
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
