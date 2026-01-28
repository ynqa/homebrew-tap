class Nosy < Formula
  desc "nosy: various contents summarization tool powered by artificial intelligence"
  homepage "https://github.com/ynqa/nosy"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/nosy/releases/download/v0.1.0/nosy-aarch64-apple-darwin.tar.xz"
      sha256 "eb7d54253c064171fc9168a3629073ff151eca58e22ac2579579ad3472da7411"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/nosy/releases/download/v0.1.0/nosy-x86_64-apple-darwin.tar.xz"
      sha256 "f5b7022546d2fbc59200ef8138fda2228225cc2088d0ba2f2b573eb50fc5a0be"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/nosy/releases/download/v0.1.0/nosy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "944449b97ecd05ac470e66b99bd0b6d77786ba1ab6d9f305d8c1e06762e9c889"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/nosy/releases/download/v0.1.0/nosy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1c3158e21958d81eb78e999ed911f21c8f11c306d9336d2e17c178ebe3ff026e"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "nosy" if OS.mac? && Hardware::CPU.arm?
    bin.install "nosy" if OS.mac? && Hardware::CPU.intel?
    bin.install "nosy" if OS.linux? && Hardware::CPU.arm?
    bin.install "nosy" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
