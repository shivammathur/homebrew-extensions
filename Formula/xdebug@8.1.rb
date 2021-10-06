# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.0.tar.gz"
  sha256 "0a023d9847a60bb0aff9509d92457e9c0077942d09e8bedb8e97bd3b90abd7a0"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 big_sur:      "beb9a9646a25014a947497106efc34064e40db893ba5fec02a546eba122f832d"
    sha256 catalina:     "bafd8b7ef730f0f34663dc3afac8d51c95e0eb60f25aac504c34ab1200712557"
    sha256 x86_64_linux: "c962120bf11c74ea47fdeadf9c209dc3bd05f69e37000aee695b9ebc23af2e73"
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
