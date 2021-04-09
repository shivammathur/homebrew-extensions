# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT56 < AbstractPhp56Extension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-4.0.11.tgz"
  sha256 "454f302ec13a6047ca4c39e081217ce5a61bbea815aec9c1091fb849e70b4d00"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2b3e0b3e325becfc38f23b61b6d6971408cf8b0a5cc7abadafbc986d1a0e4227"
    sha256 cellar: :any_skip_relocation, big_sur:       "cbbd4ece1390be2ce37a92e5edcc37b6943922b6a63b8805f3827f1d33145ecc"
    sha256 cellar: :any_skip_relocation, catalina:      "05a2015c696c7af16f78caea49c53d080ab0fd62639bec86f0a6d173d80945e8"
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
