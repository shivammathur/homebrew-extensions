# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT81 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.1.tgz"
  sha256 "3a3587c0a524c17d0dad9673a160b90cd776e836838474e173b549ed864352ee"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  conflicts_with "gmagick@8.1",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "aeace6b95a7cd194492200f275f555392d7c7171a49fe4cc34d437e1383b38cd"
    sha256 cellar: :any,                 arm64_sequoia: "11a359271a29c1cc1b730c18c8aa66b081b35e67b44d3a8444ca1fc132e43ec4"
    sha256 cellar: :any,                 arm64_sonoma:  "5a0ba5001a8b9afec2d7fd9989df422b307ac664fdf69f132a15addedb3bc82f"
    sha256 cellar: :any,                 sonoma:        "4d2a8ddac355cd3f87aa06d7175d26a423747069f4c427643152143cdffa4221"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3732a977ead9f256d22c68645f1776698514a814efd85466c70f01292c94a509"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9df0228e284723b12b654119cc4f593b403c53a8b457fe5ec11775546583ddba"
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
