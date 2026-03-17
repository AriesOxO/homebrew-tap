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
  version "0.2.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-aarch64-apple-darwin.tar.gz"
      sha256 "8e940da5ac2767d167f2d6932e9305ba8da3292aa3f836e61817bbee315371d4"
    else
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-x86_64-apple-darwin.tar.gz"
      sha256 "641b1b266de5ea303e330fea1a85f1ce28e1dded773eb8165dab1f1d78e7e8b0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-aarch64-linux-musl.tar.gz"
      sha256 "d6a5a8f0983e5709d879bf1049ad1a17a78ca594a6562e8e6c0eb345fd8f9abb"
    else
      url "https://github.com/AriesOxO/piz/releases/download/v#{version}/piz-x86_64-linux-musl.tar.gz"
      sha256 "0bfac400303aabc406b73fde6f4d2be4c6af4775d510809ee44f505da51b2462"
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
