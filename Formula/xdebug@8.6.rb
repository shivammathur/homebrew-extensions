# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/bd9f063cc6a5c42bbd7f41fdbe5cad7b6f5f8fde.tar.gz"
  sha256 "145049882b6f190a603d902ef87e18ae3b004ee1ce7110f246364aa4e2e356ad"
  version "3.4.7"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256                               arm64_tahoe:   "d2841750249e3a6aabc8036718045cfb3081a35fb342ddac5a08775288b1ab7b"
    sha256                               arm64_sequoia: "7e161a38e99c7a5ac90f2ea2998013fec3c407d2c9b1c13d80900b5e6bcb9edd"
    sha256                               arm64_sonoma:  "ef26e40605397e23b992462aee6d0fd2a98445f9af0b7f42a51fe730d76201cd"
    sha256 cellar: :any_skip_relocation, sonoma:        "b20dd4728bf877d4f39fc7c0aade45267dcef659e8b7f90231d0ac7499a113fe"
    sha256                               arm64_linux:   "da1b1cb4e06fcc66a9211d8d2ab77df37bcebc2d9fd23a21d14681975e279b59"
    sha256                               x86_64_linux:  "3a07e986a38f694470de0c25b9183a70d6217a3a1a1ee4558839a543161f1349"
  end

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "80600", "80700"
    inreplace "src/profiler/profiler.c", \
              "ZSTR_INIT_LITERAL(tmp_name, false)", \
              "zend_string_init(tmp_name, strlen(tmp_name), false)"
    inreplace %w[
      src/debugger/debugger.c
      src/debugger/handler_dbgp.c
      src/base/base.c
    ], "zval_dtor", "zval_ptr_dtor_nogc"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
