# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT73 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.6.tar.gz"
  sha256 "217e05fbe43940fcbfe18e8f15e3e8ded7dd35926b0bee916782d0fffe8dcc53"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia:  "c110cc54c9756134be56255c08c3aa41a8bfedd72ee9047bcacd82fd34e2b072"
    sha256 arm64_ventura:  "1e9fd0a4811c0bb7749bf5b361d4f29ab3655d25d9f88771a6b4326b9de0f9d7"
    sha256 arm64_monterey: "fe6c3dbc97511dffd1cee272cbd2c8a43cecd0081e91ba710096565f578f7c83"
    sha256 arm64_big_sur:  "bcaf2c7f0d7b2a949e5643f9c16d41a242a37584368f2c2b9d6ef47610f13d81"
    sha256 ventura:        "289cef3b6e58d549fcd825d72cfe150a1a0e4e6846d34733e12f98fc3f982a16"
    sha256 monterey:       "df19994d1340ea210e37fa4a87e13d29b091def0bb03f332f374d377da952801"
    sha256 big_sur:        "85894ec59eeab4760f2cd6978c6b80277e4df976e23141d60ba78463035f57cd"
    sha256 catalina:       "fe124d42b7fe4cfe25d1c7b9d2a5e9a237b15d75f0902d9cc557cb49ab1435e6"
    sha256 arm64_linux:    "0b8d96c408bfe3c69661fefbf7fc46e35de8a94cb9160fe4901f1755535a5b06"
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
