# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT86 < AbstractPhpExtension
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
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0756af178bdf37796ad365a7bbc84554d0b57b3ea4cb903f9c6d7438d26f14a2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5ef87dfbff145e990037b01d9c0ed32560e1a01f1c14002bf910d2f33507ba7b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b32b679b006ee7cae70f64cfc262cc2ea7137c61d408d2d950afdefda1079a8b"
    sha256 cellar: :any_skip_relocation, sonoma:        "05690d37c919c563fc9fa0348a0aaecd59d73bca2c5d6995a90fccb2d2f71ffa"
    sha256 cellar: :any,                 arm64_linux:   "1df3a739e6c501744eec2f827e4bfe12eddef2780a6200aa79d42ccd6800f6a0"
    sha256 cellar: :any,                 x86_64_linux:  "389c1f46ef7633cb4f8082aa2c1c83a3438dee7af3c42e0976859c6a3f8a400d"
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
