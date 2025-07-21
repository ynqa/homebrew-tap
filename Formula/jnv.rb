class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  homepage "https://github.com/ynqa/jnv"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/jnv/releases/download/v0.6.1/jnv-aarch64-apple-darwin.tar.xz"
      sha256 "c78bca8dfd2ff2e760ce45aa97063a3a530991f9c9ed5088e7278231564f2cf6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/jnv/releases/download/v0.6.1/jnv-x86_64-apple-darwin.tar.xz"
      sha256 "9c936bb2c6cca510318231cc817469b89d7e93d8a34481bfea66fa678ea19bd0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/jnv/releases/download/v0.6.1/jnv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fdf882848471f227f3112c85cf9c690a93cc12234ce8077bdec86d3cb8292bd5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/jnv/releases/download/v0.6.1/jnv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "02e8546c2936ab57de78199099288e67ed7926ebbad50e503e4502be5df7f3bf"
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
