# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/e8d89debe67d008b94ba9e27a8c3905461e57dde.tar.gz"
  sha256 "1af44386ac8f58e10f6f2e3ccce6fb8c3a40b460f8d7515be09355d2debbdc81"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "b1f2547a55b1c15ecb1dba011f62ee31c635f5af3578f6da15cb845943cbf02b"
    sha256                               arm64_sequoia: "d2b0d4a28432699851980c9b825cc2cfe7a944b5a7fd927a9b0e7bf55e7d3566"
    sha256                               arm64_sonoma:  "b94b5545b3c9f9acc98cf71cda4af52be9499c6118b9a3add8eca3edd0e9a266"
    sha256 cellar: :any_skip_relocation, sonoma:        "bc8c2fba56ffc5db34dab9f0527f26e359c43c11ebcbbbbb5250fa4f6e20d69d"
    sha256                               arm64_linux:   "e41ea634b6d07ab6e80d8d21cf09e6403357e70103bd0f7a00a95f0b36a260ed"
    sha256                               x86_64_linux:  "13bfe00bbb02c05dfe00f86a551f77b10f5ae18b5d51cb1601d7ce0f045a3c72"
  end

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "80600", "80700"
    inreplace "src/profiler/profiler.c",
              "ZSTR_INIT_LITERAL(tmp_name, false)",
              "zend_string_init(tmp_name, strlen(tmp_name), false)"
    inreplace %w[
      src/debugger/debugger.c
      src/debugger/handler_dbgp.c
      src/base/base.c
    ], "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace "src/develop/php_functions.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
