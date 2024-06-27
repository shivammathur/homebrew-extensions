# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/604dafff3acac857617ce7a77e994a6c8840f1b1.tar.gz?commit=604dafff3acac857617ce7a77e994a6c8840f1b1"
  version "8.4.0"
  sha256 "0240eab3b83403e2cfee33ab54b376c7a86cbf2d8578b55bed1d761445a69772"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 48
    sha256 cellar: :any,                 arm64_sonoma:   "d2f67a3cb7ead776eadd0a01f08e0cd369ca5601d58d3f76187fba9677000030"
    sha256 cellar: :any,                 arm64_ventura:  "6471efcb28b2f5aac7f5ec6703d1c118b54a2fb44c33186c54dec1cf26ab2d9c"
    sha256 cellar: :any,                 arm64_monterey: "3bb81d4e9b06348da7a2dd18baea4fb9828ebaa348d399fcf059f425e9bd98d0"
    sha256 cellar: :any,                 ventura:        "3bcb03a87b90ba75ff675da0bb6e2ac627ea722d41a82461f8bb4408baa07353"
    sha256 cellar: :any,                 monterey:       "95279373ff23c4e234c2fb87879e3fd0be634792de66c9953274989c7a0ea5d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1f1ce173f8059272ba9785026dd84a5b97bcd21da5cf6ad8dab13df12e439240"
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
