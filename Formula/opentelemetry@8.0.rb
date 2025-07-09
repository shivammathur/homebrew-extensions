# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT80 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.2.0.tgz"
  sha256 "50cd327c7494b5f436631434c8a5f0554aec129e6d499ba61359131ebf1b6757"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "71879f157cb21f157d96345673268d2af6af528062d779759dad2c97d92f2028"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c02e82996aba3fb6076a31dd847536e550b6ecf3ba756c7469afdc736308dcea"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "abbcc4baeb040c932837ba5c8bf1a0ac65020423272627f13b4778f9b88181b8"
    sha256 cellar: :any_skip_relocation, ventura:       "2e537d3063a04ddc81e9d93dc36bd901afb1c6a233ab97d9aa018577996f7aa6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ef292521e66639adfd6721a91af8f83fb765d0edbb725e89c7ca1c2a327cc741"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "37da401b7c0e270b4001d323e9235274a3856a69b7aaefbceb21ab35fee6200a"
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
