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
    sha256                               arm64_tahoe:   "0cb164b126c04e779f8663c990445c0431d3c83dd4e30e7652773f69dd9581a8"
    sha256                               arm64_sequoia: "e15931de8d7702204ac9bb9378b7a5562f89568cc1bb0c14227bcb42596e561d"
    sha256                               arm64_sonoma:  "a4bf4fd2c8a826fdad368fb45e10e1d43c9630a1014d352fdd21da2574cf3ec4"
    sha256 cellar: :any_skip_relocation, sonoma:        "5e0c328c724d75f4c58bd7534e8eb333780e773215d597851d53c8821516feba"
    sha256                               arm64_linux:   "2e86d4755052726a873a291bb1f4d2c9de53fae7a17be8dbc4495cf6efef16a6"
    sha256                               x86_64_linux:  "ed31ed5ac4e118640d49d5c2c1c4125a46edb5ece754f81d782fb4f5673fd046"
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
