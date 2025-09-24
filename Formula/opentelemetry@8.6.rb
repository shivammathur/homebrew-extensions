# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9930a4e50abf60e977e7c9154f61a049ff3a74cf1a6c666763b718f85fcb1980"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e30a3bbed4f02205a0f5823656319423da15490b879329e6e850bc1b4df6a380"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4844a13d3c109f17b3abbbbdeb04f9c2202f0bed6663d82da23236d020471c88"
    sha256 cellar: :any_skip_relocation, sonoma:        "37568905c1db4fde3cd920387a437b5d9383e8631cfbd668f72d2c8d2073a565"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "52f4d61c2ed62a8379bf57db170493a864f87d1d6e6760c6a1879321fecc7b33"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "727bd61563b90f46e6f8a17e292feecab44feb076750613e3e28df8a5d3d0104"
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
