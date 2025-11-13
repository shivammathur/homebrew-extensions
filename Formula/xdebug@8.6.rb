# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/a1af24fbe7a17c663bc80bca338afa5f3a78f920.tar.gz"
  sha256 "93041978712a0c6bb394a91d3198d3cc6c1fd660a7b9b9766cfe7da5f0f3205b"
  version "3.4.7"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_tahoe:   "8a0cabcd93d2a98aca22194a6f3b14c4d3838f2ab8213e18dd2ff161282a69c8"
    sha256                               arm64_sequoia: "e2a6cdccc4317aed37b6174b4db712469ec61f48b81ead1f72237dcf174165e8"
    sha256                               arm64_sonoma:  "399e6094d6c8226d411dbdbf9396d801d6e5e909372ca6e1dde453602ed56562"
    sha256 cellar: :any_skip_relocation, sonoma:        "c7cd5dd2c6da88593995271c37cdb7baffdf50929cf100146d0fb323fb0cedec"
    sha256                               arm64_linux:   "01bf10f9564a6ab3ee6a59c66e7cc59938f087dfd8824ede51b910f16c35c0dc"
    sha256                               x86_64_linux:  "4c50df52fc4b6a9f3a491f9f43377f8abfb26cd969b92908cdc55e5b6674c5b0"
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
