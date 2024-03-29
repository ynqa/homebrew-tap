class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  version "0.2.1"
  on_macos do
    url "https://github.com/ynqa/jnv/releases/download/v0.2.1/jnv-x86_64-apple-darwin.tar.xz"
    sha256 "eb9e9e4ee9feb31befe9f2092ce6e78d448c5d449eeb7a23ab8937e34d975cf8"
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/jnv/releases/download/v0.2.1/jnv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ea81ae2da23a6e35d5df5d605f74ebfad1cba9a4c93090ba52276abc52e09feb"
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
