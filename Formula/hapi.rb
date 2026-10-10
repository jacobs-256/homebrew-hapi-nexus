# typed: false
# frozen_string_literal: true

class Hapi < Formula
  desc "Private multi-user AI coding agent control CLI"
  homepage "https://github.com/jacobs-256/hapi-nexus"
  version "2.0.6"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v2.0.6-261010/hapi-nexus-v2.0.6-261010-hapi-darwin-arm64.tar.gz"
      sha256 "64817faf87c520ecc69386b582157ba24e7669b789610c7299e15382664f38db"
    else
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v2.0.6-261010/hapi-nexus-v2.0.6-261010-hapi-darwin-amd64.tar.gz"
      sha256 "8ccb72141a8f36899501879614627209e1a69b178b89a89f1041fe1b4bca939f"
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
