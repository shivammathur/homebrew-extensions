# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.2.tar.gz"
  sha256 "3659538cd6c3eb55097989f40b6aa172a0e09646b68ee657ace33aa0e4356849"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "82d5653cb71835ccc8fc77bd9bad70c7a249484d513588cb0349fd66671c9a64"
    sha256 arm64_sonoma:  "a62125311afe079302b08ed528c5c4624055365e862d791ff565b878aecea98c"
    sha256 arm64_ventura: "8bd9d78a19c15a32c46b94fa6eaedcd8b29b49c66d8fe67fb09b13d40d299956"
    sha256 ventura:       "30a46a13eb35970c1c5139960d70dc01e4721f726bede3331b66f0552f6f6fb9"
    sha256 x86_64_linux:  "415f869e2848013ebdb27bca9baaaf2c5dc62cebbb257a467ae27ae50c190c83"
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
