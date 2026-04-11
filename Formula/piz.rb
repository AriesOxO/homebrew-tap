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
  version "0.3.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-aarch64-apple-darwin.tar.gz"
      sha256 "fd4eff060ea1d4a1e63d8034f1c2fdb41904b787af6edb917fef15f50fd52da2"
    else
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-x86_64-apple-darwin.tar.gz"
      sha256 "f4140e7235f35fa5328fa6c7ad0b1471dcbe518da7faff7b5b5a8477cfdfac03"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-aarch64-linux-musl.tar.gz"
      sha256 "b7079c05751021a955f7b64f15d704c6f3e0a05f7f3354486eb1d3c91cb14900"
    else
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-x86_64-linux-musl.tar.gz"
      sha256 "6c470e8978b13ad7b119bc3a92a412fc5cc20450e832420bf76d1d535c8ea6fc"
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
