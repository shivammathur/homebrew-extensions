# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT73 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.0.tgz"
  sha256 "bda67461c854f20d6105782b769c524fc37388b75d4481d951644d2167ffeec6"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "19a1511097b549abcc43f82be5ce3a461df3c34e3f03084a6fe7349341539c9d"
    sha256 cellar: :any,                 arm64_sonoma:  "a62e3310bd85afe8f7a445e7a77ec155e951370c9ead524b06f38f7d8c0ba22e"
    sha256 cellar: :any,                 arm64_ventura: "979602ef857cd7fe1e94371691c347585dea68a3c3464afb5bcf761a9466e68d"
    sha256 cellar: :any,                 ventura:       "d961394802c350d506bb019e213ecb083148dcc798c095e27ae7a56bf443aab9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58439398957074337b4086874627875cce35b3f5f2e811d19ea8e40f7cd86735"
  end

  depends_on "imagemagick"

  def install
    args = %W[
      --with-imagick=#{Formula["imagemagick"].opt_prefix}
    ]
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
