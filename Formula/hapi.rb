# typed: false
# frozen_string_literal: true

class Hapi < Formula
  desc "Private multi-user AI coding agent control CLI"
  homepage "https://github.com/jacobs-256/hapi-nexus"
  version "1.3.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v1.3.0-260815/hapi-nexus-v1.3.0-260815-hapi-darwin-arm64.tar.gz"
      sha256 "8492bb4af55bde113bca294cc914cf0fe4a11deaf42d8e10ab5775148a38cb94"
    else
      url "https://github.com/jacobs-256/hapi-nexus/releases/download/v1.3.0-260815/hapi-nexus-v1.3.0-260815-hapi-darwin-amd64.tar.gz"
      sha256 "75e04ce1ab35a3ba24c6aef534939385e72ccd7248c5898e89a8b82593f9cc50"
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
