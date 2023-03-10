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
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "39b75e9b1fd7f3ec3f6ea354ed3b35f63f2459801a82b36f47b322ec26d8ec68"
    sha256 cellar: :any,                 arm64_big_sur:  "96769a494bda6563d93b220dd94c7e1de3968266e4d14337402f3c9c3a9c178b"
    sha256 cellar: :any,                 monterey:       "9148762285cd413a5807511a0b58605c74d905648f44b5eec9ba90b75c5c111f"
    sha256 cellar: :any,                 big_sur:        "bee48d2b9eba41fa7dd91a5f900f2fb02abbb5949f9dd5b85ab76b9d6e8c05cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "df4cccd2afe9142935ef6bacea09d8911f5dbfa8d2e10c21ee66096ea2a7fabf"
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
