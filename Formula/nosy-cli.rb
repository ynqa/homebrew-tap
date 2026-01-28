class NosyCli < Formula
  desc "nosy: various contents summarization tool powered by artificial intelligence"
  homepage "https://github.com/ynqa/nosy"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/nosy/releases/download/v0.1.0/nosy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "59f81a67f2d44a72bf07e4c6f917f706989678dab77516318d1c9fa526652e99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/nosy/releases/download/v0.1.0/nosy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "9b67164ca62a280475ff8526fd1836482d9f2e9820d76e9e00dd3c355a2902e4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/nosy/releases/download/v0.1.0/nosy-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a02f078163754ae949fbea7846b8dd11e09af54a329e1dcbef556f5e7fda261a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/nosy/releases/download/v0.1.0/nosy-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "25af3cb9b0393f281d5a16848c3c3ba269498886f745e8b820e8fd932703b92b"
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
