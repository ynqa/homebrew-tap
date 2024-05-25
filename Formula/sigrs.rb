class Sigrs < Formula
  desc "Interactive grep (for streaming)"
  version "0.1.0"
  on_macos do
    on_arm do
      url "https://github.com/ynqa/sig/releases/download/v0.1.0/sigrs-aarch64-apple-darwin.tar.xz"
      sha256 "c9c571a7fa3c4acc6403774b6fe936b6d319a4ef0b5ec4768a65b2e215b0c8f8"
    end
    on_intel do
      url "https://github.com/ynqa/sig/releases/download/v0.1.0/sigrs-x86_64-apple-darwin.tar.xz"
      sha256 "6c9dfbe98f74ee589611df7a293e2fbfc2271a289ec73fcabadee5b1735a19b8"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/sig/releases/download/v0.1.0/sigrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f58f4dccfc2dacea77d4cece9bccab8ea361278c6f6a28cda73b150654de16eb"
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
