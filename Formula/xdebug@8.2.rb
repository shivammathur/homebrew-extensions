# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.1.tar.gz"
  sha256 "9cf77233d9a27517b289c66e49883bdb4088ae39056cd0b67c3a1d8596b21080"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "7b042a97f206513f8c91a51c416696a9f1c2a487bba6c57876f13f87e87f976b"
    sha256 arm64_sonoma:  "8e58fb0efefc91817a183058a5778a76c3b4f79b17a8a37153426f3e4d1d96ef"
    sha256 arm64_ventura: "d76d78a8d985098aca50d8bcb43b43a8f046f637a6f2127fb7c19666fe0d11db"
    sha256 ventura:       "4bd405e0ef8ac80ae5d0de5e764b4400e478a552e753e031db2a8de51e9d3bdc"
    sha256 x86_64_linux:  "7357afd70711fa1ebd353c41bf0c30c942157c22e3d445efcb9fb62603373c33"
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
