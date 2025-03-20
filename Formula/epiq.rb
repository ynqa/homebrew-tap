class Epiq < Formula
  desc "Laboratory for pipeline construction with feedback"
  homepage "https://github.com/ynqa/empiriqa"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/empiriqa/releases/download/v0.1.0/epiq-aarch64-apple-darwin.tar.xz"
      sha256 "77f68f3b440ca8a299357600e3be306cd72f8f9352f5b09f126d6d219378c0da"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/empiriqa/releases/download/v0.1.0/epiq-x86_64-apple-darwin.tar.xz"
      sha256 "e7d48fc2ed6fa637b010ff04384cbf332ffd9ffeace81ddf2af8b822938e4945"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/empiriqa/releases/download/v0.1.0/epiq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "01e7e7697f3609b279cce16f4ae2954eb75637a64cd2f039ddc2760d34acc7fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/empiriqa/releases/download/v0.1.0/epiq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "869ceebd88d11444061cb97f51ef402cc331e56ab923ecea88b27f6033cf25f4"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
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
    bin.install "epiq" if OS.mac? && Hardware::CPU.arm?
    bin.install "epiq" if OS.mac? && Hardware::CPU.intel?
    bin.install "epiq" if OS.linux? && Hardware::CPU.arm?
    bin.install "epiq" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
