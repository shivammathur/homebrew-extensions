# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT81 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.2.0.tgz"
  sha256 "50cd327c7494b5f436631434c8a5f0554aec129e6d499ba61359131ebf1b6757"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "15987a8cdf0a05a1357f4793899b6410a90d146caeda8fb2695613de62b9341c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4257ce892cea391700fd88430fbb19f41865829a15de45294d08e496164562ae"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1ddd4906287b6d18c553e3eacb218c9e3a0b11def74acc7b95f65589e4a4c98e"
    sha256 cellar: :any_skip_relocation, ventura:       "bb67eaaba49a354d5e12f79df7395ca4d41095f532e868d4fa61d88ea1e3581e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c597ecdcc6c9060bfc83764add9c82be95883673e6517cba2a3b69c6aa811ae1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fa06e30bc406b41a68f119c37e1c64ed493cb94f8cfdb181db7d220c73869704"
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
