class Bul < Formula
  desc "Interactive log analyzer for Kubernetes"
  version "0.1.1"
  on_macos do
    on_arm do
      url "https://github.com/ynqa/bul/releases/download/v0.1.1/bul-aarch64-apple-darwin.tar.xz"
      sha256 "be7a3b3774695d50a3e21c1d0ba6c9d8e3078059785c5ce1919b6ae192dd5915"
    end
    on_intel do
      url "https://github.com/ynqa/bul/releases/download/v0.1.1/bul-x86_64-apple-darwin.tar.xz"
      sha256 "cec22cc21e1fdd2106a093f1bc57e0c2338e31112634f0bcf46c16f90540ed11"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/bul/releases/download/v0.1.1/bul-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "796a4d7da8e8389163297d91d6fc96cf6d3a5291870b3187cb8f41ac820a8c09"
    end
  end
  license "MIT"

  def install
    on_macos do
      on_arm do
        bin.install "bul"
      end
    end
    on_macos do
      on_intel do
        bin.install "bul"
      end
    end
    on_linux do
      on_intel do
        bin.install "bul"
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
