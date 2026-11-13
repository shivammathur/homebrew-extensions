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
  revision 2
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "9b7a833dd4ae211007b7d4e8d87d88e8e054c7e2fb2031251b94529b1ec8c5bc"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "0d58dc4476103289ed93a4864d3f02dc5976b143cb8d5551d61a527c01c9840e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "cfa3dc323b389f357aada13439cef20bb60e3080de240b81a7fdad334c217067"
    sha256 cellar: :any,                 arm64_linux:       "376d5d3c638281c0ee0b97a4f0aa6393b740f237c61206e4914f074b5acc8ffd"
    sha256 cellar: :any,                 x86_64_linux:      "823cf4e5e9ac09cee027842578fdd106e3389591a5af918ea3e128b5d7d5395e"
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
