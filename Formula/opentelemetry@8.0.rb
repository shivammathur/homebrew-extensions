# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT80 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.4.2.tgz"
  sha256 "a355329259f373c5c7327e66310481726cfabac50cb5483eba000bec791d5017"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "e8d3a57ad6f46d688c9e429e9b00cdbacd0dd7b6b1f3a52d3cb786315e58d370"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "c53b6882953bcc8f8b13781e44e8baa90bbe63e0325020b2607b496c10ecf0b7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "40b79145e30ac774e748549147b0228d2f9a41cf3ebb75e2294262e420546fd7"
    sha256 cellar: :any,                 arm64_linux:       "dd9a33441b23fac8ab4b5ca1b5cbfcd9d4ebec4446ee6e3e08bdba1bd09c4e84"
    sha256 cellar: :any,                 x86_64_linux:      "5afa9b78d3a9c21b62ea54c5124158dc61ab2cb11f8233a43f2d37f9bede3203"
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
