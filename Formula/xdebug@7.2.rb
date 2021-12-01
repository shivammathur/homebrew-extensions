# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT72 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.1.tar.gz"
  sha256 "f8d46e0127b4a7c7d392f0ee966233bf5cfd1ade7364cc807fe5397c7de0579a"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "fc7ef9377c61d3f19da5dfbb4b793cbe1ab2baf130f6c76e43465ce3eca79bed"
    sha256 big_sur:       "a411b171db40b179be025e41f73cc81e67b41093069bb4f216508ae1757bdeeb"
    sha256 catalina:      "e3915ad8df694949d65effd73bcc029dc829a9bdd49c21262d5a799496ccca26"
    sha256 x86_64_linux:  "9cc1f7deaf843194ba1957b181e415a4b7a43c4aab7bdc86d9ea972734ddb968"
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
