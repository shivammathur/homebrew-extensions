# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/65e43ec5e11adc05f306663b5dc511ccf9001121.tar.gz"
  sha256 "fc14a0307989695f787796073954b87d0bc4aff89c6f0e89e2195d84ea4957da"
  version "3.4.7"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256                               arm64_tahoe:   "c6b6ba73aaf8e52ec398c510492713cfff19a43f0efbc690551c3fd2cff6f80e"
    sha256                               arm64_sequoia: "5c79edb2bb7121b76d183963bb66dce75720069bb372e91a8cd6ce38f1a959ba"
    sha256                               arm64_sonoma:  "226205b3b5214a39edc3ca3be830e92fa59cea5036dfc15b7d0104bb97e7c05f"
    sha256 cellar: :any_skip_relocation, sonoma:        "d7698e0e2778fd99c235eed338e7420940180a3fad6b9fda49d7ba2e33968b6e"
    sha256                               arm64_linux:   "c703685bf659bb84d4f397d363cfb3daa2a4b632def88b48864ce892dcd2360a"
    sha256                               x86_64_linux:  "1fcbb728d93b69fab14d3c4af6bc900f5b100cfc46beabd5a011baa0decf55b7"
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
