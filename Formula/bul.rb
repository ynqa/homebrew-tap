class Bul < Formula
  desc "Interactive log analyzer for Kubernetes"
  version "0.1.0"
  on_macos do
    on_arm do
      url "https://github.com/ynqa/bul/releases/download/v0.1.0/bul-aarch64-apple-darwin.tar.xz"
      sha256 "7a8bf64d4de385e2c6fc44641e7b5952998c8f85210f56c93fcd979d885e6660"
    end
    on_intel do
      url "https://github.com/ynqa/bul/releases/download/v0.1.0/bul-x86_64-apple-darwin.tar.xz"
      sha256 "4babe75ed33e760ddffddc3818a3e83bf550741904b04482644622f5179cd03b"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/bul/releases/download/v0.1.0/bul-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c7e6bfa9e0c711a81551b3747a821eeb8689e695e5ef918361298e3303fa7352"
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
