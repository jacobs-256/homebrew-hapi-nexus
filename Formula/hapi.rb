# typed: false
# frozen_string_literal: true

class Hapi < Formula
  desc "Private multi-user AI coding agent control CLI"
  homepage "https://github.com/jacobs-256/hapi-nexus"
  version "2.0.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v2.0.1-260819/hapi-nexus-v2.0.1-260819-hapi-darwin-arm64.tar.gz"
      sha256 "67acb96485a619d6b49dd80b140a4e50eb9b7fd684d1619e3acbdf2f02541207"
    else
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v2.0.1-260819/hapi-nexus-v2.0.1-260819-hapi-darwin-amd64.tar.gz"
      sha256 "8fd5386def31e6b6a6aa2650c45749b02f155d9c732ab9ee1a1a98d8e03ff454"
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
