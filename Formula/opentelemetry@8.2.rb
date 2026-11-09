# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "62f919785a024cc9e8f2ead2aea10dcc5413efa5220edfefdcef3dcdeafd929b"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "d76cbb0aa06785ca2888ca86eda6008d793db6a09c9c00f7e6b2172d8d0b03ca"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "0422837ab1b1b17bee935017436f05b03f6847b5d766c1735544da438e2a2d9c"
    sha256 cellar: :any,                 arm64_linux:       "caa1313aa6d016b8f20bf9fb9a0940f7b80343c8973cd04c0a7ed42d483f3f0b"
    sha256 cellar: :any,                 x86_64_linux:      "5469da10a63b400d19abcb8460dc3675f290e08e0b7fa630226b4fb93873984b"
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
