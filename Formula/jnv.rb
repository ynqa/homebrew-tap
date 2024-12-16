class Jnv < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  homepage "https://github.com/ynqa/jnv"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/jnv/releases/download/v0.4.2/jnv-aarch64-apple-darwin.tar.xz"
      sha256 "ef43c9462f3f64dedf2e9558ee67c6b07bf2f9605e7a19a9e62b3c5cd1e9bf64"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/jnv/releases/download/v0.4.2/jnv-x86_64-apple-darwin.tar.xz"
      sha256 "fdf7101be0681544ff617911608db5305161edc2c6cf7d99fc5609d3ac309066"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ynqa/jnv/releases/download/v0.4.2/jnv-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "46f81f13e7175ec0a8e1e1505beb45957e20cc50940663d1bb17f6ea136856aa"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
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
