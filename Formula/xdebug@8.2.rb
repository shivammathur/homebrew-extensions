# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.4.tar.gz"
  sha256 "7e4f28fc65c8b535de43b6d2ec57429476a6de1d53c4d440a9108ae8d28e01f4"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "87fb8b3acfa3bd165afaf255b1af3eed1743a184d1138c0d64bba29a440632bf"
    sha256 big_sur:       "3376e35a09e8e95e1635d6f224afc1fded82dc3a7430633ff0d216db79f5b421"
    sha256 catalina:      "dce185b0923a1f2bca29ab2fcfe62c9e27d06652d63505c87773fc7a0e34fdc2"
    sha256 x86_64_linux:  "dffedd2e4a19de5b21a07cbe70161584da82c81830b92188bb8d720a10845de9"
  end

  def install
    patch_spl_symbols
    inreplace "config.m4", "80200", "80300"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
