# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.1.tar.gz"
  sha256 "f8d46e0127b4a7c7d392f0ee966233bf5cfd1ade7364cc807fe5397c7de0579a"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "f401495863775a0bc7a9224ba171c8e0f987b985fce2fd24401eba574ac71db6"
    sha256 big_sur:       "beb9a9646a25014a947497106efc34064e40db893ba5fec02a546eba122f832d"
    sha256 catalina:      "bafd8b7ef730f0f34663dc3afac8d51c95e0eb60f25aac504c34ab1200712557"
    sha256 x86_64_linux:  "c962120bf11c74ea47fdeadf9c209dc3bd05f69e37000aee695b9ebc23af2e73"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
