# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.4.tar.gz"
  sha256 "7e4f28fc65c8b535de43b6d2ec57429476a6de1d53c4d440a9108ae8d28e01f4"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "ccd59cc6b57ac4a598e16f6af3786d8e5b390b29cf5241f964ff5bc4bfae4cbd"
    sha256 big_sur:       "cce2106f067283e827e89860a8faad8d48083c42d747205ea3161b4ff991706e"
    sha256 catalina:      "a73f1f3ae428a7c74afce7492a356e5bf7b1d5ec4ea4f5e4bd5aaa599ac060be"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
