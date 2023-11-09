# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/fc66f37d61f189b9f15a21ae0bd76644e1714667.tar.gz?commit=fc66f37d61f189b9f15a21ae0bd76644e1714667"
  version "8.4.0"
  sha256 "6cbb98f196e10f31311ef78aca834f9c2c6360d03e3f51a37654fee743ccfa05"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sonoma:   "0b7040cc9cf57707a59844544ba3acc833b8bf76d2cd6eb450041e4fb2233fa9"
    sha256 cellar: :any,                 arm64_ventura:  "a65ffd57d648efb07b19a464fa73f5014ad73442ca7912ae5df3ae2906771f67"
    sha256 cellar: :any,                 arm64_monterey: "c085e391df2a1f021035b7e7610522e039cd1893a427ef52edc517d4ef6136ca"
    sha256 cellar: :any,                 ventura:        "4d5d30dd7be3aa283195ab792bfa0bd0a6123a6552e7a6c88f5dced4192363f8"
    sha256 cellar: :any,                 monterey:       "75ebe6771993fad4ec47faefefe45fe1b8c9693d4c8fcdd475c0f158e0c4133a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ebf50606d9b2f1febd9e2181807f2734c11a965a98648a846fb0d437875256a1"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
