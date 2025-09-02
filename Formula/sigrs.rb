class Sigrs < Formula
  desc "Interactive grep (for streaming)"
  homepage "https://github.com/ynqa/sig"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/sig/releases/download/v0.2.0/sigrs-aarch64-apple-darwin.tar.xz"
      sha256 "cd03a685dcb008e0be362cc1c606ffcfc887904e80e4b55fc07583cccc8edeb8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/sig/releases/download/v0.2.0/sigrs-x86_64-apple-darwin.tar.xz"
      sha256 "60d6ff423bba4a52812c98cc0f23261be34f52b41afdb9c9831bf4c40d042017"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ynqa/sig/releases/download/v0.2.0/sigrs-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "37e08fd21de13def1f6f6575bde71eff973da0a7443af4d8aab6f8a44b65bffa"
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
