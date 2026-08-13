# typed: false
# frozen_string_literal: true

class Hapi < Formula
  desc "Private multi-user AI coding agent control CLI"
  homepage "https://github.com/jacobs-256/hapi-nexus"
  version "1.1.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v1.1.0-260813/hapi-nexus-v1.1.0-260813-hapi-darwin-arm64.tar.gz"
      sha256 "8b711a3883eeca25c40934ba41e926254dcec28eb903c9506d016515c93b36cb"
    else
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v1.1.0-260813/hapi-nexus-v1.1.0-260813-hapi-darwin-amd64.tar.gz"
      sha256 "b98bc2f24e6f591de2f05bf96a2bfc4f08309060eb676ec2aa38f6da6ff27fa0"
    end
  end

  on_linux do
    odie "Install HAPI Nexus on Linux from GitHub Releases: https://github.com/jacobs-256/hapi-nexus/releases"
  end

  def install
    bin.install Dir["*/hapi"].first => "hapi"
  end

  def caveats
    <<~EOS
      Connect this client to your HAPI Nexus Hub:
        hapi auth login

      Start a runner for one or more allowed workspace roots:
        hapi runner start --workspace-root /path/to/projects
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hapi --version")
  end
end
