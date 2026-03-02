class Sigrs < Formula
  desc "Interactive grep (for streaming)"
  homepage "https://github.com/ynqa/sig"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/sig/releases/download/v0.3.0/sigrs-aarch64-apple-darwin.tar.xz"
      sha256 "1f40b450f49af0ba15f3be51c44130e5e2efd99e51858e7790f7e6b2c393bb4d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/sig/releases/download/v0.3.0/sigrs-x86_64-apple-darwin.tar.xz"
      sha256 "a5ceb2ecc5b8f9dd469c2210517e2124efdc972f1158f09be6ecca86b5e2ec56"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/sig/releases/download/v0.3.0/sigrs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6a01f132019871f21997a50290ec84c6b67e583aac8ed5a33d56f36e0b2ddfbb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/sig/releases/download/v0.3.0/sigrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b43710f0b36a3237edd8d1dbc08aad5377c0c8b1ccb2500dab154bb00a6bb57f"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-pc-windows-gnu":            {},
    "aarch64-unknown-linux-gnu":         {},
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
    bin.install "sig" if OS.mac? && Hardware::CPU.arm?
    bin.install "sig" if OS.mac? && Hardware::CPU.intel?
    bin.install "sig" if OS.linux? && Hardware::CPU.arm?
    bin.install "sig" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
