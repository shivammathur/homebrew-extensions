# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b1178a973488d2f8aac706a86135ea894be7c02219cd641e867fe692cce670ea"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "62710bcabc50d2e353031c868f241170be338b0ca736fa272e85f84a9683c077"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0597e27e1219d9e9073a208883ae5a6e1aa3bd41f0aec621dd5708df65d33e72"
    sha256 cellar: :any_skip_relocation, ventura:       "131d4b2503e2356857920e0f9e50d532d14d889fe2bc56125eae6b32cfb28eb3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bf6c26a89bafb9bb9e72be648489ba6746a606ec9baed9312fb6809361ce37d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "57d727a6f5535c14c881d1b79b51aa1b9b0fb2fada957d1257d298bb9bc3c85e"
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
