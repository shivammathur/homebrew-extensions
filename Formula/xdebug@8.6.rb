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
    rebuild 2
    sha256                               arm64_tahoe:   "06f85f14f5d8655e135a8086b9ec100a9d765cf9f11ab525bb541265bf231a6d"
    sha256                               arm64_sequoia: "13b8839581fe586956388b8752fd5bfae4b404b8cfc9ed9e3ed5b4f5479aa7c6"
    sha256                               arm64_sonoma:  "9d85cd303bbadcb9a3f92b9d0e257f702423c1c5cd57d31b66748b548ce1151e"
    sha256 cellar: :any_skip_relocation, sonoma:        "6476a1a27eed102340da859bb0e057c3f27e8e1bad7da0ff619a2ee866ec82ba"
    sha256                               arm64_linux:   "19fe8ef845f73d79024733fdc3fffff048c73f3a0080de6a47a81328a4afec47"
    sha256                               x86_64_linux:  "b203bce90e68b61dc8d21100f18b82b8fb19bf87aef640ba76acc8c3eb18bc91"
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
