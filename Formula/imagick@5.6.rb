# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "86b6462b9846673e2ec06e4816a818de4af5c2877d4b3f51fbaf9ce2ab45ec61"
    sha256 cellar: :any,                 arm64_sonoma:  "b046a7462273bd39fc672e8af0d79a0c5bec60eb4450cd17fb01f974b0ecbaa5"
    sha256 cellar: :any,                 arm64_ventura: "2da4d8548934b80cb390a8e45a3390cc7d92fae9bb4098b02701ebd43c234f38"
    sha256 cellar: :any,                 ventura:       "abdff750a5f1244d44777bf612155dbede3bc4537fcbe27f71ae5cc7501e3064"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a26a80ac3440961f7e70f8aec73fd11ca269d5f213bf5938e0eb1a7b6448cf8d"
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
