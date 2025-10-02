# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT84 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.2.1.tgz"
  sha256 "de8315ed3299536f327360a37f03618ab8684c02fbf8dfd8f489c025d88a6498"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "73caf7ceea215848d61b90fe4e99798c2c3f9accafac27b32edfa7cb04773338"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2893a8e2a16f19c1ef3b07ef020e761ac27f17ba337649ad41de51b8ddec47c9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cee20b8754530159e0869102a736125791b8e7ff3d647309e390f5c783126685"
    sha256 cellar: :any_skip_relocation, sonoma:        "bdcf2d50ac079fa4fdb2aec253f1dbf335968a721c41942de6a62c07451df19f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a1c283ba7d42353a4900d41b000063c24056b45dd30f3aa871b44156c642b63e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "91c150b863897def8f5a069a0e47ea8080592f4975d09512770aa5e551b7e348"
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
