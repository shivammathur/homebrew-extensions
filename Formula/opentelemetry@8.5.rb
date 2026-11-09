# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "a63a339b1a1fd083e4488231cf0229d51a6901effd913ff3e80d651326768ea1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "56e8c460cced9856b25180775de349a9cfcf6cc622aec8a3aa1b179107cbe585"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "76affc7affc292e86fc6ec7bafcfdfcbf49d7794bbe0e25913bf2c941f4f58dc"
    sha256 cellar: :any,                 arm64_linux:       "c4bf122af0e05a0ab5f68c0f60f5046bec3d504f90e2d307763c429692c0a8a0"
    sha256 cellar: :any,                 x86_64_linux:      "ec89b6d6a1e5aa1dd6089c6bd6fd18221fad4ee2cca393c11e9192139c6da9ad"
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
