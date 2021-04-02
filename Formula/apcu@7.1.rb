# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT71 < AbstractPhp71Extension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.20.tgz"
  sha256 "b99d40fafec06f4d132fcee53e7526ddbfc1d041ea6e04e17389dfad28f9c390"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "121c6bdcc966f805c367785063a3a20b04adb52b68fb154f90a6a946015e1e5c"
    sha256 cellar: :any_skip_relocation, big_sur:       "725cb5263b31d2f11f2d6b511e1fd76681c091b7c6d2c9f6723c96c0331526c2"
    sha256 cellar: :any_skip_relocation, catalina:      "6a28ef46f0b5dd23a8a0a6f5f8e5e253754082e61f0603a12deef0c2bc4f2277"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
