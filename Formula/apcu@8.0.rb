# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT80 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.20.tgz"
  sha256 "b99d40fafec06f4d132fcee53e7526ddbfc1d041ea6e04e17389dfad28f9c390"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "518832b2f9726bd24222aea033f541e5304ec4bf862265d21f8ad2a2f3528433"
    sha256 cellar: :any_skip_relocation, big_sur:       "877db22261b4146ca0e2fe92ac480ed43555d6c4074dc08a13120140aa3af846"
    sha256 cellar: :any_skip_relocation, catalina:      "32cfb2405fb97a337c243e157e59aff17aef8bd91c7322a23a37f198621276df"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
