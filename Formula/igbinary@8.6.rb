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
  revision 1
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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "311c3431868e7bab9be1bcbbeb00b0297b955e06b07fa6908cdc95492d47b772"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "973dd84b6f864fd0364c59e7b5a5c1776297bb3a19aa41e6cfa9dcdf91abbcb0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7829251d40c912487f84f6aaf782a6490434f1a89e8ca0f199fafa89329dc24b"
    sha256 cellar: :any_skip_relocation, sonoma:        "9d8597d8125e1afe38de5c09ae58079d3c6c17f3789deb90953e00acea6a1132"
    sha256 cellar: :any,                 arm64_linux:   "f8b3dc24e790489594d366eef2ff4b75e7ea2bf3e1b72ba53bd83163a81792eb"
    sha256 cellar: :any,                 x86_64_linux:  "a6949e4f2f4b6e18e6d262f81add2c7cde519d811025faae0a6570bb24c12933"
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
