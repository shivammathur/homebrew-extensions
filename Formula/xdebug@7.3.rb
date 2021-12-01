# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT73 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.2.tar.gz"
  sha256 "57cd63b25649171218c749f8fed808dea7d641bc4fbb4427356d00056ac24c68"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "cb0350e0d16c913c88a136bce12ac8129f50fb7f764a40c677ed360ef56542d4"
    sha256 big_sur:       "6d84d1cb4cac958cf91ada605dd2e79818db03cbd7a2ffda0576b75296cf19b1"
    sha256 catalina:      "ed72ba1e169609c60d1d655b72f805895869ad85f500bbe8a3aa249238a8ff5e"
    sha256 x86_64_linux:  "7ed768f8eae6b0bff9d34f8259bf31e37e7f7ad6c799bbbedf864e5f2864d886"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
