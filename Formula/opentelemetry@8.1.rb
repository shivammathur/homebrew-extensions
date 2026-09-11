# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT81 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.4.1.tgz"
  sha256 "981edebd3d01b942a7863af097316d725922467699b16d0a70ccf56f37c14a04"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bb32f8b04b3d0a5d92249bdaa5f56292bff40769cb5c7cb8d0f1336d2f1cf0f1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d87568be2daf6481275b49e2cf85ee9f1785b62ac25ad677fffdc2d7fc3d56fa"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "245ec6389d9e3c61eecb980555d0ce12b30feedcbc711420d0578f5d0e7f4d34"
    sha256 cellar: :any,                 arm64_linux:   "60f6112dd9af934625d90963fd9cdd44246533b9eed6925ec4b6e7999c1a581a"
    sha256 cellar: :any,                 x86_64_linux:  "021398264a25f41406538ab7a3d9f2e588e642825624f3d585fdd061b8970d30"
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
