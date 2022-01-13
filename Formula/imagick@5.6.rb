# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "c66a65c5edd917b31b28b93b9e9b732895b3c565d4f79cd81a6a25c11958b4fe"
    sha256 cellar: :any,                 big_sur:       "28b1aea160115ff81fb442b416b6f510b61545df74517e2b61b9ad9c968095b1"
    sha256 cellar: :any,                 catalina:      "c8f351afa3e545367e77dc1e3e49ec22197d5139280a28e26cef882d804326b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6af5fe8e03d9b9d1fbe835164e6983d7c9f2f9537532c3a1fd75d869da8b8cf8"
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
