class Sigrs < Formula
  desc "Interactive grep (for streaming)"
  version "0.1.4"
  on_macos do
    on_arm do
      url "https://github.com/ynqa/sig/releases/download/v0.1.4/sigrs-aarch64-apple-darwin.tar.xz"
      sha256 "3266eb902d5270cf54a75f8aaf87032d919bd5f9ac4a2c1397f1f9cc988a9317"
    end
    on_intel do
      url "https://github.com/ynqa/sig/releases/download/v0.1.4/sigrs-x86_64-apple-darwin.tar.xz"
      sha256 "c790c24108b6c7b5f33dce893096be10846eaff783c39490fa82170ea41899b0"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/sig/releases/download/v0.1.4/sigrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "30de373c237511e44d4a7dd19dd3ee485f5ab5c50a2a4b0ac223f7c680871d79"
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
