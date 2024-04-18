# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.3.2.tar.gz"
  sha256 "9d2001cb8c4d5a2f6302e1bb303595a01c0337dd4e0776b05e8abcb526020743"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "9791d0a091221c2cb566cb7994b241bac1869fd2adac5666a9562f1be7141466"
    sha256 arm64_ventura:  "5bc671af8dcb391604263c835a8c4bca50fd325823d614d535ca44ff6d64df2b"
    sha256 arm64_monterey: "dd35618ac779a29b0216df5ed49f99b0d9bc1a96c450afd84f6914beda5cc4c2"
    sha256 ventura:        "f5f9df677424ed773e3b83b872396ae4f7e0efa1a90f6ddb10d973a7478bc229"
    sha256 monterey:       "4e8feddefeba79fce8ddc02f2a6532b8c7b9923318828a988c845c35cd65e0ec"
    sha256 x86_64_linux:   "233cd63550472052874ea83212e66469c8092c55f9fafa86935471ae4687e29e"
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
