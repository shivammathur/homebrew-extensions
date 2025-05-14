# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT83 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.1.3.tgz"
  sha256 "8371225bbc4dbd6ba3e966b1588c22c81c6a87fcbece64cd2b3294cc03b2885d"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ccad2524629bcda178ff20a7b16f2726949291056e77e59e41ecccc8230d0bbb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ac0e5efda158356315d6156736f94b2da92bdb96f9cd4e4839fbdf2d194b746a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c55697813aae813dd0c74b6a0c44a6d687e6db39734da7afb7d3e2c75a8dd04c"
    sha256 cellar: :any_skip_relocation, ventura:       "249085fcdb3c947dd60e864d0444ed34355cb30985734a85ca227f33e4b42cb8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "59a98cdc318098bfb83ca4beb1753ce3de2bb76a3929ca60c7eea925f75dfe5b"
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
