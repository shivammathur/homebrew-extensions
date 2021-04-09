# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT72 < AbstractPhp72Extension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.20.tgz"
  sha256 "b99d40fafec06f4d132fcee53e7526ddbfc1d041ea6e04e17389dfad28f9c390"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "da0491b24121f6910e24d9914f93000a4b5560a11244329136a29f40c684c9c5"
    sha256 cellar: :any_skip_relocation, big_sur:       "6ed02d732c4b94123f81022d63e806c3d6823552146b92771763a8f3ec37c11e"
    sha256 cellar: :any_skip_relocation, catalina:      "0fbacc769b1bbe360b91e994902f644399badd9d1a61e2d86d04703ec254f847"
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
