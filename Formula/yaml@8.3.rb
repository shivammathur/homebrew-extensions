# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT83 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.3.tgz"
  sha256 "5937eb9722ddf6d64626799cfa024598ff2452ea157992e4e67331a253f90236"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "3427c006f751420b1d62e5690dca0b83788985c9aecfc03ca290920b81926dbd"
    sha256 cellar: :any,                 arm64_big_sur:  "3c523f6934a3012b9b9e27769f82cd3e750cdaa6359d5bc81d09efb39d261f16"
    sha256 cellar: :any,                 ventura:        "ed1541bfea5f5f909f9838b8db556697239363b0b8d288afe4b3fc910d036c91"
    sha256 cellar: :any,                 monterey:       "05ac939cdfd0cde28934b7d56e6b5e946fd66521c95ca535a96b5d7008b1dd42"
    sha256 cellar: :any,                 big_sur:        "1558e13960c97b9b0548f9e01dcf399ec06c335c291ab6a50f565801ee0fc2db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "94d2773115d60b2df1068824e9f9d494139bf2e4240dbe0d20875674e4726ff2"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    inreplace "detect.c", "ZEND_ATOL(*lval, buf)", "*lval = ZEND_ATOL(buf)"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
