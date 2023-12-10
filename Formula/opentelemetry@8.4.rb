# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT84 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.0.0.tgz"
  sha256 "c986887f3d97568e9457cdeae41f4b4c1ed92b340b7533ecf65945eb7e291f74"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "279c2d10d6e98a7ad70a11ddb2efdfce6879b43bd8a680a3e042f9977d04f3f9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "373ac9355a6c98eef840e13cec1ba6e1223dae057bf4a2528ef446c63d8dc62f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dcc674fc12fd98f73f0fd3a8a21592d60cde0a92f3e5cebca4d6262856bc115a"
    sha256 cellar: :any_skip_relocation, ventura:        "d9b4728fb91fbf75285699dd56a447577120dccc97893ceb350071108f67012f"
    sha256 cellar: :any_skip_relocation, monterey:       "0ecda2975e7c94f08538ff646f1a16733930d996c10f92d11fe67bc46f9c861f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "54eb63339cb3431efb8f82bc38a56ccc8a473963f1abe66643e6d1badd7c58f8"
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
