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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "95c9120130c153c2081d6e0dcc4ee65515b459765196d11fcc8df653b6b96a7d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8477633d15d914f417c6449bf0a43bdc16a508b01331ce1374c384e0c1a3f2f3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c54ed8c7a02ca7e764a16282a4332eb9c819a67d5b51678b07a26e81c5e83c7c"
    sha256 cellar: :any_skip_relocation, ventura:       "0fd427688c19109f6146006368fb736abbcd90cf798a102217a6fac5eaef12a2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "674f364bf32638078e3406e7c303818b64f73826cee2cf6097f4077436c4b0a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "561005832cc627fdb48b7c8881553d20a1b2880e4cba953b18edbc036f841983"
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
