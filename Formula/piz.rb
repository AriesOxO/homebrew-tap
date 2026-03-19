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
  version "0.3.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-aarch64-apple-darwin.tar.gz"
      sha256 "3d6fbf3d052b43aad5f5f981303bfc325ac2e9a05edd5b2736449992437247c7"
    else
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-x86_64-apple-darwin.tar.gz"
      sha256 "6132518c8516dfc55b03decc42cf7e27959b5f4a3fac0b2500d4be5f7182740a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-aarch64-linux-musl.tar.gz"
      sha256 "7006c2daf0edac71528fd4d5e07182e276600ddbb596a158ea54ab6dae1a3994"
    else
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-x86_64-linux-musl.tar.gz"
      sha256 "c85365033cc94a33fa3db2c9ce96bd40d19905aa6d01aba830d1667d1debca0d"
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
