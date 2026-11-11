# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT86 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  revision 3
  compatibility_version 1
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    strategy :git do |tags|
      semver_tags = tags.map(&:to_s).grep(/^v?\d+(\.\d+)+$/)
      semver_tags.max_by { |tag| Version.new(tag.delete_prefix("v")) }
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "e8f5f48aaedfc2dd3c17987d1e08d8d99cc963e8da82db71ef581feb9ca4d087"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "9ff853dba72fa355bab2bd53258107d0ea691ff31f67c1d1ebc7cd9ce5c6e4f2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "6e6df63e2db4cc67a1eece0acc6678e441f6f7ebcf532b31acb24362b096f41f"
    sha256 cellar: :any,                 arm64_linux:       "2d90f55dc8611a79b1851ddcab7a9ce831c381d2bf459e2aa1bd9e064619dbc1"
    sha256 cellar: :any,                 x86_64_linux:      "ea231f74ec6805faa8244599c31a604a3df6195ce3de5c895d0bd5b9ac28477a"
  end

  def install
    patch_spl_symbols
    safe_phpize
    inreplace "src/php7/php_igbinary.h", "ext/standard/php_smart_string.h", "Zend/zend_smart_string.h"
    inreplace "src/php7/igbinary.c" do |s|
      s.gsub! "zval_dtor", "zval_ptr_dtor_nogc"
      s.gsub! "const char* user_func_name;", "zend_string *user_func_name;"
      s.gsub! "(user_func_name == NULL) || (user_func_name[0] == '\\0')", "user_func_name == NULL"
      s.gsub! "ZVAL_STRING(&user_func, user_func_name)", "ZVAL_STR_COPY(&user_func, user_func_name)"
      s.gsub! "PG(unserialize_callback_func));", "ZSTR_VAL(PG(unserialize_callback_func)));"
    end
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
