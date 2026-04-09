# Homebrew formula for piz
# This file is a template. The release workflow automatically generates
# the actual formula with correct version and SHA256 checksums,
# and pushes it to the AriesOxO/homebrew-tap repository.
#
# Usage:
#   brew tap AriesOxO/tap
#   brew install piz
# Or:
#   brew install AriesOxO/tap/piz

class Piz < Formula
  desc "Intelligent terminal command assistant - translate natural language to shell commands"
  homepage "https://github.com/AriesOxO/piz"
  version "0.3.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-aarch64-apple-darwin.tar.gz"
      sha256 "f74c74f57a08df98934264fa05f35b0a0b5835a86dde906d32987bfc623cf2bf"
    else
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-x86_64-apple-darwin.tar.gz"
      sha256 "9a36edea254a95d3a1b3005f367eff8a25ad7b97d58bf4fa4c0c0c9f2ab3480e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-aarch64-linux-musl.tar.gz"
      sha256 "494af2d88abdd7df99868de1956400a9186066a35f2e09725f5e8d42243351b4"
    else
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-x86_64-linux-musl.tar.gz"
      sha256 "87bca52ade1032a5d7189d0db192ccae56f1fe8c5a5ad37a20ed340edd0fb69c"
    end
  end

  def install
    bin.install "piz"
  end

  def caveats
    <<~EOS
      To enable shell integration (cd/export/source support), add to your shell config:

        # bash (~/.bashrc)
        eval "$(piz init bash)"

        # zsh (~/.zshrc)
        eval "$(piz init zsh)"

        # fish (~/.config/fish/config.fish)
        piz init fish | source

      Shell integration also provides convenient aliases:
        p  → piz
        pf → piz fix
        pc → piz chat
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/piz --version")
  end
end
