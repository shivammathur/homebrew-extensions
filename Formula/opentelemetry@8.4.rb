# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT84 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.5.0.tgz"
  sha256 "796676e071b2c6502c4dbdacccd1a2b29e12bf81d5d514b7ba85ce37de232073"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "b5a74f73eabfe3c22dc180cc757208c32c548106ff1a12623f949e6477354324"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "94719c09801e7dd9a57ee53edc0ede47fc05e4f9809058773a07cf7cd2e7d429"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "49c060acda388e70316f6750fa8cbc9c8388991f02691758c43acc815b1aaf8e"
    sha256 cellar: :any,                 arm64_linux:       "1eee869fef9badccd82de066079975b0a5c04d0a4103c14203b0ff22a5cf1b6c"
    sha256 cellar: :any,                 x86_64_linux:      "610da7540093b223777214d221e6de426f5b179a9fe417f3f127cfa001f736a8"
  end

  def install
    Dir.chdir "opentelemetry-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
