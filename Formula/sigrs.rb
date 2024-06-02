class Sigrs < Formula
  desc "Interactive grep (for streaming)"
  version "0.1.2"
  on_macos do
    on_arm do
      url "https://github.com/ynqa/sig/releases/download/v0.1.2/sigrs-aarch64-apple-darwin.tar.xz"
      sha256 "bffa76985db22209af58288e4af20ef0646b75fce305745771a4eb24f87a5666"
    end
    on_intel do
      url "https://github.com/ynqa/sig/releases/download/v0.1.2/sigrs-x86_64-apple-darwin.tar.xz"
      sha256 "590fa404735374b820a670e47f89b518e8adf254704f6213112ef355ec47616d"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/sig/releases/download/v0.1.2/sigrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a68b8ce110364dd84a3cb798a57cc681b1e365ccba0b78cbe3bb7dc7e85f35eb"
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
