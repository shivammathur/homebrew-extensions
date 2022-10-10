# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0alpha3.tar.gz"
  sha256 "10fe3f5bb20ed104fa55e11e2c8616bae94fbd8286b3f2388639decbfe7dfacb"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "ce342196508b55913e3ed0f06ea9df2c1ade3872591de3b85c6cd08041b63a44"
    sha256 arm64_big_sur:  "d297cf072407966f6207411ef89a942c7ee5de97cbbeee418b0d7507c14b45df"
    sha256 monterey:       "0e9cba699382994e668d7e60de54098d8aab8f6ad77b29e7ba0ca4429abcd2b3"
    sha256 big_sur:        "588abe43042c2497c2a4ad4561311ff9b8eb005189ab1c3d50bfc0422e3055e8"
    sha256 catalina:       "e247241c6221df201fbbe9352cb11e3fc6be221641c1e1e5bee6bf7e30103b45"
    sha256 x86_64_linux:   "b18b416ff7d98a1b243f963e86c63296a42305e952fb03e429b8a231c436044a"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
