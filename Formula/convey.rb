class Convey < Formula
  desc "Compose and send prompts to terminal sessions"
  homepage "https://github.com/ynqa/convey"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/convey/releases/download/v0.1.0/convey-aarch64-apple-darwin.tar.xz"
      sha256 "6d7390b43bf920106456427f5191264f9349d6e61ac9a0e49da568c4c7ba4978"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/convey/releases/download/v0.1.0/convey-x86_64-apple-darwin.tar.xz"
      sha256 "cd3d23bffca1b76aef225183bae7f8abe07048ef17f062fc933c1d4be3597051"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin":  {},
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "convey"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "convey"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
