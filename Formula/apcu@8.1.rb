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
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a851e9c4b5d4c1cae488f5c9619bfdcd580131692b42a24109bdca88515cc473"
    sha256 cellar: :any_skip_relocation, big_sur:       "03898e892ed8723184d1d5ab1d59a3d53f5f0d7d4a6e1bdc64c7ff3a11b86cd0"
    sha256 cellar: :any_skip_relocation, catalina:      "23408c9b6f47203b3d9be71a26ea828ab4c3758fab2d5055bdc5bb6da5b8e05b"
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
