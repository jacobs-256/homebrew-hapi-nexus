# typed: false
# frozen_string_literal: true

class Hapi < Formula
  desc "Private multi-user AI coding agent control CLI"
  homepage "https://github.com/jacobs-256/hapi-nexus"
  version "2.0.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v2.0.0-260819/hapi-nexus-v2.0.0-260819-hapi-darwin-arm64.tar.gz"
      sha256 "b08a1acfbae73d214e01cfc1259cd6edf41975c222ea6159f2360bf2f7ca7863"
    else
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v2.0.0-260819/hapi-nexus-v2.0.0-260819-hapi-darwin-amd64.tar.gz"
      sha256 "bf17666d96f174befba8c8ca24fd4b1af7174f14d74a2dc1e5682c94424c25f2"
    end
  end

  on_linux do
    odie "Install HAPI Nexus on Linux from GitHub Releases: https://github.com/jacobs-256/hapi-nexus/releases"
  end

  def install
    hapi_binary = if File.exist?("hapi")
      "hapi"
    else
      Dir["*/hapi"].first
    end

    odie "hapi binary not found in release archive" if hapi_binary.nil?

    bin.install hapi_binary => "hapi"
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
