class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  version "0.2.0"
  on_macos do
    url "https://github.com/ynqa/jnv/releases/download/v0.2.0/jnv-x86_64-apple-darwin.tar.xz"
    sha256 "d282b9429cd30ca725fc9e1fadccc072ccfa72309955cf781f7ad43c96ab3b50"
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/jnv/releases/download/v0.2.0/jnv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9f4ca7d550314e0f030336055fe3906ae6348d970617948e02829f24304c31fd"
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
