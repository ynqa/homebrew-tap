class Sigrs < Formula
  desc "Interactive grep (for streaming)"
  version "0.1.3"
  on_macos do
    on_arm do
      url "https://github.com/ynqa/sig/releases/download/v0.1.3/sigrs-aarch64-apple-darwin.tar.xz"
      sha256 "108f93df9e8f59d4ee01f6d22809ca6c52b51aa059c9131652c358828f161ae8"
    end
    on_intel do
      url "https://github.com/ynqa/sig/releases/download/v0.1.3/sigrs-x86_64-apple-darwin.tar.xz"
      sha256 "dc26837695edfb5dc7db73d44e2001cc06b1da2326645e75ec57e36d8b93c6c4"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/sig/releases/download/v0.1.3/sigrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "99e8b40f6f16ce5481e40ffb1c10c263ce006e656ff652d1a7b7bfc67e4a6162"
    end
  end
  license "MIT"

  def install
    on_macos do
      on_arm do
        bin.install "sig"
      end
    end
    on_macos do
      on_intel do
        bin.install "sig"
      end
    end
    on_linux do
      on_intel do
        bin.install "sig"
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
