class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  homepage "https://github.com/ynqa/jnv"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/jnv/releases/download/v0.6.0/jnv-aarch64-apple-darwin.tar.xz"
      sha256 "6b0a38c3c31f30b87ad411327d80bec0e5b2087ab3e4653ae8fa25876896852a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/jnv/releases/download/v0.6.0/jnv-x86_64-apple-darwin.tar.xz"
      sha256 "9d3e9718750870c7d2c807a2b585ff4694e6405af54277674ea47ae6b2731023"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/jnv/releases/download/v0.6.0/jnv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "10c2227de7097caff4074d3b8dd506b826c1419a065edfaa9a463ef4ccfe31e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/jnv/releases/download/v0.6.0/jnv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6896d748c315b066f2a6dbe73e3a5540353c8c960184f374d7758c5e7e30906a"
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
