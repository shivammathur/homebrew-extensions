# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT87 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  revision 2
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "65b724ef941acda3e59403c454f079d86f02f4c3a998184bfd0633932198c56d"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "1396b3d4819a44bdc607a01b5d26175c78ffbd228d3915df255a2ed9fe4b3846"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "9dd352511b7f36ca0283e9f35386649b8b2707d9b69179be83be219c36bb5670"
    sha256 cellar: :any,                 arm64_linux:       "b42f0509dabddb060cb2b96d756199bfdfcfa7fa4d8a13e0a3c389e347e861a1"
    sha256 cellar: :any,                 x86_64_linux:      "643355a9c83204ef8602a9d1447c1b5f24aec45eff3c867435ff49f23e621762"
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
