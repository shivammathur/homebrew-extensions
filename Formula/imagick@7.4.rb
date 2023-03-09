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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "1c5ddb6d4e12515e060ba43a5c64da0d5f228ebc6fad2d24cb73b074a9cfb472"
    sha256 cellar: :any,                 arm64_big_sur:  "31883f8dcf03c65c423642d3842fccd2a3c38411d00a6f5ef618569ba5fa6be8"
    sha256 cellar: :any,                 monterey:       "9ff453c8a63915ed1011a934bdc43914736d80040ba60f005c3908ebdd8d7d56"
    sha256 cellar: :any,                 big_sur:        "8fba7cf3fa61af4c86ac5de9ce816176b8d3c7d7b373873e9e35eba138b8db31"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "801242a8ffabdfb3693c8b3f860a85ec332242923d93bfe972315b4af3e31c63"
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
