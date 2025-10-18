# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT74 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.6.tar.gz"
  sha256 "217e05fbe43940fcbfe18e8f15e3e8ded7dd35926b0bee916782d0fffe8dcc53"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia:  "6160312dd3a2f90f5a3f6df4d94c7423968cbf9a4390e727a95806f380b916bf"
    sha256 arm64_ventura:  "23d415f21e02cdc58e73f1a722f556d32b6a208e6606545072de48697b9b773e"
    sha256 arm64_monterey: "b159d154d361dd85bede60b5e022ef1760845e9b42b8b863095936dce228cd45"
    sha256 arm64_big_sur:  "ab9bca1022c1243036d51a852412960dfd1f1da57e79eb19fdb1d03c4fc8e3c3"
    sha256 ventura:        "b2f8e1b2079d0e9fd436dd52f8df4ff4d3606c2bfe3d41c41a8466de463bdc51"
    sha256 monterey:       "8db8eb07582f265df2044db5251f75d03acfffc87dfff32e63bd1d37ac7611e5"
    sha256 big_sur:        "b83e210c171ab66180684a86c13beceefd9a472284a005024665cc3020dd39dd"
    sha256 catalina:       "6ab0c95388ab54af02f6fdd731eec06f3cc61c7b4bf590eb1782716537e6b39a"
    sha256 arm64_linux:    "4028ecfaaca4bcf81bf03cc3f86e512d9594016d414a91d98711671652500abb"
    sha256 x86_64_linux:   "e0f9e52312d052a041620c4ddbdbe68b16acc70c145a6ed5a351de903bb78bf1"
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
