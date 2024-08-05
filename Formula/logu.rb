class Logu < Formula
  desc "Log parsing for message aggregation"
  version "0.1.0"
  on_macos do
    on_arm do
      url "https://github.com/ynqa/logu/releases/download/v0.1.0/logu-aarch64-apple-darwin.tar.xz"
      sha256 "cb7c791761694283be9fb889c470bcadb9ee88d31985fcd3d26daca8253fed06"
    end
    on_intel do
      url "https://github.com/ynqa/logu/releases/download/v0.1.0/logu-x86_64-apple-darwin.tar.xz"
      sha256 "8f45057792d71593312c5d2ff15e1e67e08ca72633d314bbc0fd181da51c0870"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/logu/releases/download/v0.1.0/logu-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "10664c4037da9da16df63961775b382514fdbf52c384431c9a887e2202edd686"
    end
  end
  license "MIT"

  def install
    on_macos do
      on_arm do
        bin.install "logu"
      end
    end
    on_macos do
      on_intel do
        bin.install "logu"
      end
    end
    on_linux do
      on_intel do
        bin.install "logu"
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
