# typed: false
# frozen_string_literal: true

class Hapi < Formula
  desc "Private multi-user AI coding agent control CLI"
  homepage "https://github.com/jacobs-256/hapi-nexus"
  version "2.1.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v2.1.1-261030/hapi-nexus-v2.1.1-261030-hapi-darwin-arm64.tar.gz"
      sha256 "23c0187016095720cd8900e4265b9fd606eb384f15e60d765bfecc8d222102ca"
    else
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v2.1.1-261030/hapi-nexus-v2.1.1-261030-hapi-darwin-amd64.tar.gz"
      sha256 "995393ab2673fda8ba6c833a9c2d9e328a79b7a64e03a802459837cffb80039c"
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
