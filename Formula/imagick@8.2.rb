# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT82 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.0.tgz"
  sha256 "bda67461c854f20d6105782b769c524fc37388b75d4481d951644d2167ffeec6"
  revision 1
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "83207979a3d6e547848e688427f7f5c021a368655261d7e58ee177bfba47d60a"
    sha256 cellar: :any,                 arm64_sonoma:  "af306ff067032789a1a76f7c48de85a6a40703128a8a35eaeda31d08bad1d06a"
    sha256 cellar: :any,                 arm64_ventura: "8376877bceccb9fcb6669bb6ac3bbf2591f5a125935f5c4c8f4a65ccd9c7844d"
    sha256 cellar: :any,                 ventura:       "896947bce75e7c365d33c3b5581a4ddb8cee9601dcf93707b958d9936b413054"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "608f54d30d9328ecd8aa5fadf32dcead388516486c91d38fa57f5604816d1c86"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e4cbfaf439d36dfd6d3fe554c9320594ca87a7e7c0282da99490727320f3a7b1"
  end

  depends_on "imagemagick"
  depends_on "libomp"

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
