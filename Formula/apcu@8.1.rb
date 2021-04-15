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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b537454d578feb7abbd2fe3075882f9b04ab28bd3754b09332305209a857c464"
    sha256 cellar: :any_skip_relocation, big_sur:       "02531fd46143ca4ae85bda3a7d7cab59b527a67652920e9d273e1ccd46a4b94a"
    sha256 cellar: :any_skip_relocation, catalina:      "de443ce8bad3d005f7f03b09bad358431118d0172379bb3470dddb5298221ded"
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
