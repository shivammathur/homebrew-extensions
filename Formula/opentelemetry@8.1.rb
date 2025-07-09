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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "177d23ffae9eb6592fd3f9f3181375635ff9aca5d046d328c9a19406ba106c4e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7fc40607f9d8326707f8b2871ba1731373657c0f8242386b6f0eb30b9272946a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f0c5d9112448dccd032e0b3f67016defcccf0c08776fcbd3fa188a2f3b80d50b"
    sha256 cellar: :any_skip_relocation, ventura:       "5df64801835d4c5e40c3a3906d3e41bf75885e9ea962d9bee8156644c32f471f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3b8aaea90a65d3761b69588c3a3bf664e35ca3bd8571621b849edb356a98adb4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7e0af7339f7d64f807e32467695e528960064a09332b1ffac5a7bc49e3d64cdf"
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
