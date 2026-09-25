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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "440c00570ed59c74e9b4bb627dffd9b89b2a3acfab5a99fce39bf51594905fde"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "e77619ff91303a90d8ada191dab38f710affda806470ad4be11ae342429035d2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "16e1bd5246a4cbb9f315daa57565007dea0f0d5093402161b88d5ee158417419"
    sha256 cellar: :any,                 arm64_linux:       "2d8250444ec9c79924c403ff7096baa8d18f9fbd812313a00e39b30220c2f573"
    sha256 cellar: :any,                 x86_64_linux:      "b93efc369d75de9ef056b07be37670df67a9624badfd23df5b997c97440b1505"
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
