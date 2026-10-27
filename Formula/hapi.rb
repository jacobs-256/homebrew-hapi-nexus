# typed: false
# frozen_string_literal: true

class Hapi < Formula
  desc "Private multi-user AI coding agent control CLI"
  homepage "https://github.com/jacobs-256/hapi-nexus"
  version "2.1.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v2.1.0-261027/hapi-nexus-v2.1.0-261027-hapi-darwin-arm64.tar.gz"
      sha256 "aaa7d696faa589c5d967ccfbe34b7bc8a68ceb2bfef588d3cdcf845189154072"
    else
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v2.1.0-261027/hapi-nexus-v2.1.0-261027-hapi-darwin-amd64.tar.gz"
      sha256 "4291b5478727748d865d1f4d7b17d4ab1a7ca58daf5a91ccd5e5ac669f6bf6da"
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
