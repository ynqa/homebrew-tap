class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  homepage "https://github.com/ynqa/jnv"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/jnv/releases/download/v0.7.0/jnv-aarch64-apple-darwin.tar.xz"
      sha256 "6353bc6df13d23305b5982c510c083179d8d04a2f4e05f746afd4212766bacd1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/jnv/releases/download/v0.7.0/jnv-x86_64-apple-darwin.tar.xz"
      sha256 "686104c23555b4be05e7b914a5c3ddf948fc8de7b5a0342751f15dc6e4ce5db8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/jnv/releases/download/v0.7.0/jnv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7dfa68799fe92bdb0f344643e1d8fc43551e99e439d6f2152c5b84de48ea95a3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/jnv/releases/download/v0.7.0/jnv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6181e2fb056620b231478b2f866ddc48099f4ff4fed83fba156d74bfb52fd2b3"
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
