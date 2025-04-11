# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "18ae7c4d07767ddbcad78333409f725b766d6e69b7e55ea29c3c2d143c110fba"
    sha256 cellar: :any,                 arm64_sonoma:  "e125559ff418396a78934193194c3051d8e0cd8db0aeca8921dcf4f19584f25c"
    sha256 cellar: :any,                 arm64_ventura: "07de68a340842a0f5b2830a785d3a38889b0b777baf2b92414a6b15850c1091b"
    sha256 cellar: :any,                 ventura:       "33c10a65105ea0288682a7fabdcc53de82bf1a2bd4f45b8d5b6a37ce4bfb76a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c22433d5e13c21f192dedb12346cc33cfd68fb3bcd6e6deb2b043546b0b5f0b"
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
