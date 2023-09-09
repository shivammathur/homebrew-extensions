# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.3.0.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "b29aeee5554054b5253132b381b74cc0fa22f38ade2ef5723fceeeedaed2aef6"
    sha256 arm64_big_sur:  "57b9123e0253193e24668a12fba8dca2053c1232ef3fb5f3cc7b5cf4cd6246e0"
    sha256 ventura:        "7975f9d259b4b867d5cf15bd7eeaaf29baff8290a200fbf040511ebcaedfdd5e"
    sha256 monterey:       "34f881af6aec95e4d1569d6eb4a1648954a3dc6fbf3426870614b135b9ac02b0"
    sha256 big_sur:        "f94c08f47c5e7a1ef72576bd59e601f524108dbeb5ea55d9703b60fb1cf404ac"
    sha256 x86_64_linux:   "cc8331d4d71c46e98d76a0fad4dc6065015a39a2b86814c200f1131963b68dd0"
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
