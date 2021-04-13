# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT74 < AbstractPhp74Extension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.20.tgz"
  sha256 "b99d40fafec06f4d132fcee53e7526ddbfc1d041ea6e04e17389dfad28f9c390"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c6bc44a946d756ce3b5e02a08cd5ebdf1eac94275c160b9c1a24a569cf422b68"
    sha256 cellar: :any_skip_relocation, big_sur:       "5d22cbd3c60d954325af5b3b3f85b3d3ec94b5008bdf45cce6568d0bb32fa775"
    sha256 cellar: :any_skip_relocation, catalina:      "fe6d8c466531f8dd0a602d531d62b5edcbe34dea1acc6ee9bfeb9baa11113292"
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
