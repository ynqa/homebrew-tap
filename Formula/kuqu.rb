class Kuqu < Formula
  desc "SQL for Kubernetes resources"
  homepage "https://github.com/ynqa/kuqu"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynqa/kuqu/releases/download/v0.1.1/kuqu-aarch64-apple-darwin.tar.xz"
      sha256 "45dc74434de7f1a8f54422c6930cd0b73e0dc88a9244c700161c9d8957078e0d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynqa/kuqu/releases/download/v0.1.1/kuqu-x86_64-apple-darwin.tar.xz"
      sha256 "a41cddb91c8f211276912a836153fd0ad81a5336025158345be19b33ca7cfb04"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ynqa/kuqu/releases/download/v0.1.1/kuqu-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "db065f0be1427f152c396e2f1a0a9498f6a87c0f205851c610511e0fd6101062"
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
    bin.install "kuqu" if OS.mac? && Hardware::CPU.arm?
    bin.install "kuqu" if OS.mac? && Hardware::CPU.intel?
    bin.install "kuqu" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
