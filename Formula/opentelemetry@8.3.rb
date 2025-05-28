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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0f849206db4297e36d6649419a9bebb102175a25a73129db09ade0a25d607bdd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "597105d1214bcd4f06adf06f388dc44991e5860e28e4277a71853f63e95c5e56"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ba7058e34ee9f268f55883313d0d433c7e370bd628aa75757600d8d5982c92aa"
    sha256 cellar: :any_skip_relocation, ventura:       "404245f184992a91825f0df263023b8e646f9a0c5e4ed3c535025682f2fd5bf9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e9c5aee3526c52246baabff7339da6fe626a4a10a6e0f4836c38345708464fbd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "27d783c37a96ad58d7770b9ff14f97d917ef7a877c2253b9330b4a0abb696cba"
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
