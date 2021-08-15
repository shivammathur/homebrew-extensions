# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT81 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.1.tgz"
  sha256 "e17ad04e752e25fd099bddd2df9d26dfef183c8d00c4179bc9d7a2e1c97d7819"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "0b9f31627a2c73c2d0cc065e7eeee24cfb15ac60c417485884a00fb42d029a39"
    sha256 cellar: :any,                 big_sur:       "3a435f6025c9cdcb7abe22fd32057f679b2b785037fe8c8efc22fda4f4604e45"
    sha256 cellar: :any,                 catalina:      "5983c42802d718548d82e8a2b7978959b56e8846b983e6a0471d6f65b2b968e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ac35ee326160888c08d57f1ff4a80030e547eac16cabef1dd7b1c38a22819902"
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
