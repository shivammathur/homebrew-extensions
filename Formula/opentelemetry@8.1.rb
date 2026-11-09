# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "2b54e9f54e7a18f47f8c74fc703b097943cf5f9f2e3b7cab5661c4f1f5f5abb1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "65a65437f466b5e51ec1f8524f8bf6f3e29e7018c190ef86c5a202170a08ff02"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "304363e89698edd7b20b1a5c348cba8d286ef894f48e8274461743812b870d24"
    sha256 cellar: :any,                 arm64_linux:       "19e19caf01689973008a6b65340ab416822d942f034e0501c94dc2f75ff43c97"
    sha256 cellar: :any,                 x86_64_linux:      "cb65f7620069cce4d55d4b991b4260403be16e88f70e7fad6ced298cdf41830f"
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
