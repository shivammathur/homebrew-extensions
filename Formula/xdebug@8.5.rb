# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/63820dff8de808550fb37d52a35cb567a5210671.tar.gz"
  sha256 "b4144b1022209ef289a5fdccf7f3404afabc82f133e1ef3e2144686a58243a63"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 arm64_sequoia: "7fc94ed29ac5bcdbcaeb13a6b59c7df2cd31eff5d5376e5f2921557e86fea6e8"
    sha256 arm64_sonoma:  "258af50d74c1836cd085771dc353c004413d7d8bac0808a0af48710d3505647a"
    sha256 arm64_ventura: "ce86b12dd91aeb8a71c0fc4960b6c5cfb1adf6070a26ed55543b0d77c3ecd2ff"
    sha256 ventura:       "cfb557ea4faabf3543f9da7cadd74117c8c680e44d1d23e2d4ab466c1c76715b"
    sha256 arm64_linux:   "e2c486945eb00942cdd17048338873c4844630c022b9766e2c5244b5c425e070"
    sha256 x86_64_linux:  "365ec1e51367c0d85e4b6c6c05ae0db4ff7ab58562dd71dc1c2f62eb0362efdf"
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
