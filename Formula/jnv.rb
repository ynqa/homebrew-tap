class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  version "0.4.0"
  on_macos do
    on_arm do
      url "https://github.com/ynqa/jnv/releases/download/v0.4.0/jnv-aarch64-apple-darwin.tar.xz"
      sha256 "37682881cc789393299bda1cef1306fb749c7e40a584ba7565498d153ec47344"
    end
    on_intel do
      url "https://github.com/ynqa/jnv/releases/download/v0.4.0/jnv-x86_64-apple-darwin.tar.xz"
      sha256 "a730201cefc5ef3339e8db8cd503348ff6a1b5cfe738138ec13cf1634acfbf1f"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ynqa/jnv/releases/download/v0.4.0/jnv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0ba18b5f305548e9c41f3472ce2ef2aa56f49fed6da95c738aa16e8e51b78050"
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
