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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "354b8e4bf06534e128b1eccfe878320255241e6f952dc55fce571c68f8dc6030"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "19f07fdc689d402931e61705f1fb1548ecfd3880485901300b3bdd4d0a7529ba"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "e548e65cb9470ba210064581a85950e6e2eeed65359a41462097bb4e87ec2244"
    sha256 cellar: :any,                 arm64_linux:       "deef5817848352c5224e8142ce0afbd8bc25c142af74e48d68afe332eeb6dc44"
    sha256 cellar: :any,                 x86_64_linux:      "5fc18e889512e7672e8ea37bfe38022055fb3b64a98564d08379b09f2889db8e"
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
