# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT73 < AbstractPhp73Extension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.20.tgz"
  sha256 "b99d40fafec06f4d132fcee53e7526ddbfc1d041ea6e04e17389dfad28f9c390"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f8838a9b68b4a7093e27859ccbd9a47ea67796d82d3782dc6b03b3e58b73c2bc"
    sha256 cellar: :any_skip_relocation, big_sur:       "45e8b065a40b5a4e0c90fe7f7a8fc87ca56c6fed3ecf93d70844e312af6111c7"
    sha256 cellar: :any_skip_relocation, catalina:      "9ed902ba612d3af63e2a6e77e7f3d0db08de47ff326834040a221b58557e81d1"
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
