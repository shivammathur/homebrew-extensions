# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT72 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.4.tar.gz"
  sha256 "be80d390b6fd425eef597563a4fe71a1fd153d2b9218f749023fac57e774983d"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "d903f184fd3180c4009ebcbd779b268a29e2ee9fb843ea3be635bc87c96a7300"
    sha256 big_sur:       "2143b8d08359f62e5daa9fa927fe13019970feed59442e97e075faeb0c8d4cbc"
    sha256 catalina:      "b093fa6a585a2829dc8f89f9327d143ddaef7fb64adb09aa3db4daa3e86af6b8"
    sha256 x86_64_linux:  "5b50e031fe4b3847e59ccd53132043f4a3f761aac64026cab579188cd43922f7"
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
