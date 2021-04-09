# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT81 < AbstractPhp81Extension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.20.tgz"
  sha256 "b99d40fafec06f4d132fcee53e7526ddbfc1d041ea6e04e17389dfad28f9c390"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "73027bb6815a8cb55848bb56fe2b347489970de239ec497be77bd4f15037d347"
    sha256 cellar: :any_skip_relocation, big_sur:       "035a22f63301e607d7176612a6b350256883973cb368310fc9e4e7f7283db714"
    sha256 cellar: :any_skip_relocation, catalina:      "993705559d78046fa900ab048bb01d672af3ec5bf477655cf8d5ec796eb55022"
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
