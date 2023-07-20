# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.2.tar.gz"
  sha256 "505b7b3bf5f47d1b72d18f064a8becb6854b8574195ca472e6f8da00bdc951a8"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "f26762be32e98abf1ec3d9bfcef47425d92babee3a7e385303af4f7598a84618"
    sha256 arm64_big_sur:  "5e132010cdb254f216dad1391032b3d789de1624faeeac89822cf571c808a451"
    sha256 monterey:       "8f0500b73ad412afd43d28bf62cdf4a18c01a1bd03076b0e2d7246ebfd5a5db6"
    sha256 big_sur:        "cda6649b06016f29f29d366b01b6ecd184a8565e87dc88de7ee5b2b92d7c8cec"
    sha256 x86_64_linux:   "9585f1321909eec458dc563fd85d76930b1de1d7763dcf09858cda230fc56232"
  end

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "80300", "80400"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
