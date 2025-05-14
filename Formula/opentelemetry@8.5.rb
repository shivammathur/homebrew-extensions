# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "47d11f386217158e80e7cca1c7062be3cac93385ebba10c4a1a454a1b4b57e51"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bb1c5d7de21936b4552f5b40acb5fd987708917ef51d004d84b82473ded88af8"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d7b808c77afe904ad02ac4e3e38142598fe989acf09aa87ed35664d11a7f2f5d"
    sha256 cellar: :any_skip_relocation, ventura:       "d9390f7e23700ac9cae68109f284340b40bf37f9e3862e1df839cfdb75388779"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8b04e845e9bee35fb5eab9def10d1f8de50286667ceb4d2f2faf1c43e3268ebe"
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
