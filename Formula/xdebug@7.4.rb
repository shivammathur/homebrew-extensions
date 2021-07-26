# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT74 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.4.tar.gz"
  sha256 "7e4f28fc65c8b535de43b6d2ec57429476a6de1d53c4d440a9108ae8d28e01f4"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "077ccde7cf7f30ca777c2dddca6cb76364de26226d6f13d0d435191d4079d82a"
    sha256 big_sur:       "d6f9433f184fb9b7678ede9316590c1f39e692e2ff5a2101d97678e92ff5cdf5"
    sha256 catalina:      "9cffce00ef860048a4828c891404963a558cd204a64ae1eac545d0736f4265c3"
    sha256 x86_64_linux:  "f7b41f2dfd1c2ac11bc4c686e0d6ce277c6d9bb3a5c707dc4ba23918e2ee6701"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
