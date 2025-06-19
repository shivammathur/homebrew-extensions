# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/8fd1a39b540e8d1466bda8e7e23c7a3acef74b3b.tar.gz"
  sha256 "10205d781203f46fee540a7392b9c1ea20fd082c4a9b888f8552954a9c932255"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 arm64_sequoia: "0489e8907ec46146b79b1defadffc18f31f1eaccb9685c40fc6fbd437bdfa72a"
    sha256 arm64_sonoma:  "d5787d374fb1ba2ea1f39a29a9e5d1f663a0d67a9536f236d0fb26054b3fbf50"
    sha256 arm64_ventura: "f0cf1cb3d786fc76bd2ef80ba3ee87fb9c2146b47bb626fcbe2cafd037095002"
    sha256 ventura:       "3b7ef0e157384aa4a9b6dc2388f1237a7a0116175e09556ad79a83ea876798f7"
    sha256 arm64_linux:   "f8ad2fbb44e8ac194a95016bd96b196d813b00fbc535a83e104abfdb48741df4"
    sha256 x86_64_linux:  "c7327526f676778fbb981177b49781d8e88f1d774165329f3c03dd80ced7be7e"
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
