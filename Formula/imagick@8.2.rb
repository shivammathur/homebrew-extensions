# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT82 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "72525629bb3d709ef313163f68640b66652e7ade7719e31613ad07114e58b15b"
    sha256 cellar: :any,                 big_sur:       "ff0d43d1bfcf53e5cbe891bb00f638e4711aca3f4647e82a7e4425fbd0338a09"
    sha256 cellar: :any,                 catalina:      "744bb13955b2ae2f0cc08db30a423f9f68dddf704f7acc2305a932c785425ae9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c67de4f1e911a52d4b71c46ef3c3f9401df13812bf7a77167855d939ece57707"
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
