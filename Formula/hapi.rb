# typed: false
# frozen_string_literal: true

class Hapi < Formula
  desc "Private multi-user AI coding agent control CLI"
  homepage "https://github.com/jacobs-256/hapi-nexus"
  version "2.0.2"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v2.0.2-260828/hapi-nexus-v2.0.2-260828-hapi-darwin-arm64.tar.gz"
      sha256 "381c335c3ad3644fe0267fbb49d3571023bf8420530894420094121f1e3afe9a"
    else
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v2.0.2-260828/hapi-nexus-v2.0.2-260828-hapi-darwin-amd64.tar.gz"
      sha256 "aeee1ed3569ab098dd50b34c268545210d6222c0e0bd4fb4f6fe159afe11e146"
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
