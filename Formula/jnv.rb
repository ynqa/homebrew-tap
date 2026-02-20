class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  homepage "https://github.com/ynqa/jnv"
  version "0.6.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/jnv/releases/download/v0.6.2/jnv-aarch64-apple-darwin.tar.xz"
      sha256 "17c1cea1f28d21c00f2f2362aa0eb40f783072bc62a8b88eb1e340a7098a2b7c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/jnv/releases/download/v0.6.2/jnv-x86_64-apple-darwin.tar.xz"
      sha256 "5eb2f01d50462c97986537e29249e0bf6c588dcfb519169087b350a22d81d5dd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/jnv/releases/download/v0.6.2/jnv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "58e4937f1f81240e6b2fd80306c3b2187becfe8160b6781173bb49b41fa1aee0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/jnv/releases/download/v0.6.2/jnv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f412ee19d8c1fc28232571fbd6eb6abdae7f58a3c0f06fd16baf46b7a342b9d9"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "armv7-unknown-linux-gnueabihf":     {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    bin.install "jnv" if OS.mac? && Hardware::CPU.arm?
    bin.install "jnv" if OS.mac? && Hardware::CPU.intel?
    bin.install "jnv" if OS.linux? && Hardware::CPU.arm?
    bin.install "jnv" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
