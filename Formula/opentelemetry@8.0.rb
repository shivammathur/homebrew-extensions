# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT80 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.1.3.tgz"
  sha256 "8371225bbc4dbd6ba3e966b1588c22c81c6a87fcbece64cd2b3294cc03b2885d"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "143c32fde06be9612ecd3a1d4a300da265dfed91651f83faa1728e9007172d26"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "09388d83dd8d8a8238aba6ce51dc39a6fc79a8ce2e2a3cac7deb77108f1c29b3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6765489ec32b776a9ba4eb72ff409976947a08019982e35112ad2f90b097f6ef"
    sha256 cellar: :any_skip_relocation, ventura:       "751eca7912e3696b3cf7877f338edd045791ed46cb0f410e828ae5c2bfd722fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0aa5bbb7406a6356302af0988f662694d5cba68dfc9ee2ca483189995f9a2e88"
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
