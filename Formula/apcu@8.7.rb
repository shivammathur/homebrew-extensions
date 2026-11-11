# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT87 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.28.tgz"
  sha256 "ca9c1820810a168786f8048a4c3f8c9e3fd941407ad1553259fb2e30b5f057bf"
  revision 1
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "5ac524cecd5cad17543a6cbfba874a82c2ed9be7cc7447fba702c867a36c3d00"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "8fea6a5e28874e01cf4cd2af8ff00228a3ee90e7ee5131ba39d4a30ade012b83"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "7870333e39b6f18ff183e541afe74a193629093b66c1365c84fd3d67988a0870"
    sha256 cellar: :any,                 arm64_linux:       "3fbb63a0e5bb7ea107e2b746488345f6529924affa6d5d2d81ff20a8de63785c"
    sha256 cellar: :any,                 x86_64_linux:      "71926d8ddc813e5b5d5c2c9401d1825235abedb444323dd64d56627f9ce78370"
  end

  def install
    Dir.chdir "apcu-#{version}"
    inreplace "apc.c", 'php_verror(NULL, "", verbosity, format, args);',
                       "php_verror(NULL, verbosity, format, args);"
    inreplace "apc_persist.c", "EMPTY_SWITCH_DEFAULT_CASE()", "default: ZEND_UNREACHABLE();"
    if File.read("apc_cache.c").include?("zval_dtor")
      inreplace("apc_cache.c") { |s| s.gsub! "zval_dtor", "zval_ptr_dtor_nogc" }
    end
    inreplace %w[apc_cache.h apc_iterator.c apc_iterator.h], "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
