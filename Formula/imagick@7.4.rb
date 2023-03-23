# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "46d52752449a22c98d593e3721c1914e1ce9cface22accc2f59d3ce52c7c189c"
    sha256 cellar: :any,                 arm64_big_sur:  "220c79f4c6d81efcd7416f21bb8b3840181a031d40b4afdf3ed99636e5e2e236"
    sha256 cellar: :any,                 monterey:       "6b9326b387ceec26f18fdb7c5bc7d06e0aa9ae6ad33a97983511f130457f79b6"
    sha256 cellar: :any,                 big_sur:        "be2262e5c9be06859afb09e1b50b1b9b3bb43bc123d7603b383ea39efb0dbac4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0b0f0d572597891d911aac72c113848bd171843557ca2c44dba9296dc7073349"
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
