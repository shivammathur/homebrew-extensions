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
    sha256                               arm64_tahoe:   "07d894f40f0779482546716a6b49b545888fac4171759c16e5ca135703bfb636"
    sha256                               arm64_sequoia: "e7d0fd6c7dab25f6eb203a682f747c1b64760f7ef78b7227d6242f9433a2d79a"
    sha256                               arm64_sonoma:  "d7746fc217ec7ff889fa9ac65d351bb105dc2cadb1e5bebf7b8a1d2d25d28871"
    sha256 cellar: :any_skip_relocation, sonoma:        "71de28fdb53ebbd55088aae148708ea0dede5ab6246a4f0c55bd82f1ce375b3f"
    sha256                               arm64_linux:   "ffba2de7f3e2941e00aaa2873fa6a653f027e3209a917a198acb6c088c973389"
    sha256                               x86_64_linux:  "e07fa6024973a05a945cd66037afab6703098eef136470f335125873e59beefb"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
