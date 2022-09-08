# typed: false
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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "52f2a9276df1445ace014476edcd882beb2b24086c6150b7e52aa4a06c5bfdf1"
    sha256 cellar: :any,                 arm64_big_sur:  "02f543eefd4114c489fdb608b953c3565d78ae3767d2163323935702d7c0f3ae"
    sha256 cellar: :any,                 monterey:       "7be400ce5526d8499f30772381dfb9adebe9213a65d6a1146d22bd439a7f5804"
    sha256 cellar: :any,                 big_sur:        "0d9b7e28a051590869042365468a9c6b21b82f1012a0ebccfde2937d80b5f52c"
    sha256 cellar: :any,                 catalina:       "2f79c4a334035556d36e7f94faac36debdf6ea8c0a6150d5b30a5945adc90110"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "09ee8a286b741c4dd93065f619e79ebbbccbe62f191fb505eb34f399e8a4e110"
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
