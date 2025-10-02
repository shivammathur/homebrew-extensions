# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT82 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.2.1.tgz"
  sha256 "de8315ed3299536f327360a37f03618ab8684c02fbf8dfd8f489c025d88a6498"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dbda8f6e1b115ab12f28f6b4f560ab8e7719dcbe32708e479e10ed5da426708f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4023f3ac598df318f5dcf44a78e61cb468329111fec69dc20bc46f899a052acb"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4fc2f975e2b0c18dc277943cdd852ca281a9653d17b98e6d6c4523769e1b6d84"
    sha256 cellar: :any_skip_relocation, ventura:       "7aea06f774b868b4fbdd3bc9c29c614aa1d153327a4094c134b8dc6520751b71"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bc16faa7acaf6901325005905b2d1617ba1ab3882722390ac831d8bee25a6f3f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9f1e5de88c7a889bef41dcda926f37fc613943f396ae0510d0c219ec86ddae98"
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
