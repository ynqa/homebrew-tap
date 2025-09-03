class Sigrs < Formula
  desc "Interactive grep (for streaming)"
  homepage "https://github.com/ynqa/sig"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/sig/releases/download/v0.2.1/sigrs-aarch64-apple-darwin.tar.xz"
      sha256 "52edd801105b93bf3d1be60fbc7c429e0271311af0c08402161ebfa55e4090ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/sig/releases/download/v0.2.1/sigrs-x86_64-apple-darwin.tar.xz"
      sha256 "cd888d60761b3ac430d98d7c17e18bdfeb3c94087d11fc0a903827c1debc4542"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ynqa/sig/releases/download/v0.2.1/sigrs-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "e45a57c785fa484e888116a44554519506231401e17f817346934c77652d4b64"
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
    bin.install "sig" if OS.mac? && Hardware::CPU.arm?
    bin.install "sig" if OS.mac? && Hardware::CPU.intel?
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
