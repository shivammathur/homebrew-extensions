# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT83 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sequoia:  "b73fdefd6b94e3ca7f1c807c5f2fc81082c37c991bb05dfb802d1381827148bf"
    sha256 cellar: :any,                 arm64_ventura:  "1fe2e897c6f5f1b1d413c443bee52a009fa131fd2d9356cc39a0965e6b1dd95e"
    sha256 cellar: :any,                 arm64_monterey: "f3aacf0e567eaeb17652e0738cf8a2f79496797f04d413da7f81b0b21f5a04cd"
    sha256 cellar: :any,                 arm64_big_sur:  "e5a3bcc89a4021715aa8a91ec1a8945669afa1a38e0f4d32c5a22a589e5d5552"
    sha256 cellar: :any,                 ventura:        "802214df291bc320e28ee41905b49bb3532008b6cf2bb960e0dc436c1f774d74"
    sha256 cellar: :any,                 monterey:       "b7e8499c77587e8740bac217ba379704cd5ef52274303902c60ae633017f7e28"
    sha256 cellar: :any,                 big_sur:        "410330dab01af7dbc02a33c03b8421c5962c4de7fe247020d7c54d71fbb39954"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "55930b5d29ecb2deb27ec442eba1ba3b97131281859abf525c957b3f52260081"
  end

  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
