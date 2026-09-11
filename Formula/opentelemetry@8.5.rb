# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5ae524807998045a1c1633a758baea5a0dad52f39fa4bb247b1c780054989c74"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5c204a28b71357399a2ab073df44ab646abe0f97ae14c56a241d2c90fccf4db7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8e45701ae5cc601bed13dc303d52515a428cecbe9cac3e4ae5b1ed653ba19ff7"
    sha256 cellar: :any,                 arm64_linux:   "9ed3252504aa2371f60ac326c99be75f2e716e199eb66cc5d45c76d18a58a97a"
    sha256 cellar: :any,                 x86_64_linux:  "61ca0a3d774479a8b7531ed629aebb7d489509e20f6460e0082d02b2c9bce9ee"
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
