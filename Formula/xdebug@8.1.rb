# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.2.tar.gz"
  sha256 "57cd63b25649171218c749f8fed808dea7d641bc4fbb4427356d00056ac24c68"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "704a99ff33458a5ef43e1e544424a458ce7dcfce16585f809d58c2224bc84a57"
    sha256 big_sur:       "238ccbf8c8cb5255867653659c7eb2d23735099da655fec885d244a54ca8bc7e"
    sha256 catalina:      "7bfe2896d1431f7bbf4e9aa5e4ec2a8979e52b74ea78dbacdbf5c83b7b186394"
    sha256 x86_64_linux:  "b9be1607eef3976f43c8e1172ed3b637a913dbaaf52c1aa4ce2df179858363e5"
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
