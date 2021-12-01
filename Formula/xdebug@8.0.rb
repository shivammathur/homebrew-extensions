# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.2.tar.gz"
  sha256 "57cd63b25649171218c749f8fed808dea7d641bc4fbb4427356d00056ac24c68"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "2d0b438164d89545d21fb0a94a57d91a3aec085281ca62169c60549bdd7540aa"
    sha256 big_sur:       "580e14b4a9a2d3a5f1d98219cbf61d3fe0f31a9f76a259efa7aef4fb5891505e"
    sha256 catalina:      "34b1d13918362a18029c0328b508f858bf7e8c96157a83d9e727e73f2cacab6b"
    sha256 x86_64_linux:  "e7f407187d6a1325d7a736a6e451e802382d87b62c871ae0623a04703d39bac7"
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
