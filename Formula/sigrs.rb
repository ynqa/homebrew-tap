class Sigrs < Formula
  desc "Interactive grep (for streaming)"
  version "0.1.1"
  on_macos do
    on_arm do
      url "https://github.com/ynqa/sig/releases/download/v0.1.1/sigrs-aarch64-apple-darwin.tar.xz"
      sha256 "5c25f15f30f3ce09bd03209b56dc6f22b28f6aa63025f2eb383363be727a5939"
    end
    on_intel do
      url "https://github.com/ynqa/sig/releases/download/v0.1.1/sigrs-x86_64-apple-darwin.tar.xz"
      sha256 "ae15b0a88c446f6f092c64f89ddbb7258ce2876110b9afaa219bf716e1a85604"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/sig/releases/download/v0.1.1/sigrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9b42060cc02cba424338de68eb8d669dbdab429b1b419c6c2ab79bcbe6ca4691"
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
