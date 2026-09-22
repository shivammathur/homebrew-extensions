# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT83 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.4.2.tgz"
  sha256 "a355329259f373c5c7327e66310481726cfabac50cb5483eba000bec791d5017"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "ab6439d3baea5b0dd210013e407f6c014f3960a33df23c3fa50b41e3bb135ae9"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "7046426cb6b7a933fe6ed8ba2b91efa203b2078ff4c4c2fd06e75bacb24c192f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "d22ea612c0e39c8f1ea203582e002053883a6b049848ca7f2181744118f27941"
    sha256 cellar: :any,                 arm64_linux:       "47214d78c46498e741855a1f9ce2cf08de1a509e4ce188697f9993a0e9df2390"
    sha256 cellar: :any,                 x86_64_linux:      "2954824cc5221161d2629139fb7b2d3abee0e0ddb4dba55073baeff4c509f6f9"
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
