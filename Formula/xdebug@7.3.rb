# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT73 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0.tar.gz"
  sha256 "a5979f2060b92375523662f451bfebd76b718116921c60bcdf8e87be0c58dd72"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "fe6c3dbc97511dffd1cee272cbd2c8a43cecd0081e91ba710096565f578f7c83"
    sha256 arm64_big_sur:  "bcaf2c7f0d7b2a949e5643f9c16d41a242a37584368f2c2b9d6ef47610f13d81"
    sha256 monterey:       "df19994d1340ea210e37fa4a87e13d29b091def0bb03f332f374d377da952801"
    sha256 big_sur:        "85894ec59eeab4760f2cd6978c6b80277e4df976e23141d60ba78463035f57cd"
    sha256 catalina:       "fe124d42b7fe4cfe25d1c7b9d2a5e9a237b15d75f0902d9cc557cb49ab1435e6"
    sha256 x86_64_linux:   "344d3bd4c5667187108bd490488c1624bcbb00acece665207b19f6dbd5313895"
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
