# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT81 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.6.0.tgz"
  sha256 "4e2965f2d70dd59a40e7957d56e590e731cad2669e9f89e0fca159d748d2947e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "5650d2572e37d772dbac90e9530d200cb4851d667503ef29a4d8a6c62d91476e"
    sha256 cellar: :any,                 big_sur:       "a81fa73af764e844d0a09605223fa3d7e2fd09b8642c6eca33697f5397e403fd"
    sha256 cellar: :any,                 catalina:      "d827bdd87cbcb8f832b3d07aca6b1d0daacb2af390334d84ed2fd8b7fe48ef45"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6e90754fc6530b9022a2c9d3ca14dba7f047817f1bdb6a06d62a13d96992c4fa"
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
