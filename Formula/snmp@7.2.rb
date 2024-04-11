# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/0a6a8d7769f08bca8ae9095649b96f20b18210e5.tar.gz"
  version "7.2.34"
  sha256 "9e90d23097e1d5c462636c37aa887b405b3ca80d8cf7da10ff56b6ac2b13c5e3"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sonoma:   "892d5dbffbdbc90248d70c4d5974333c0d7f6ef83a3072e6889c694100fbfbc8"
    sha256 cellar: :any,                 arm64_ventura:  "2e9af82633c4e98647edcb698351ae592b1676335376077655bfaa467a9699f8"
    sha256 cellar: :any,                 arm64_monterey: "28869a929f58315d4911403cdc1d711c384af84a01d52e45e5c2979f5cd4baa6"
    sha256 cellar: :any,                 ventura:        "5ff6ec09fb42d2ef86cae6f29d367baa616d98871712cb3fe6ce27e66a17c776"
    sha256 cellar: :any,                 monterey:       "697b41da19ef4f825fdd7cfdafce3c4198862206f891d3f7469942da58f4d373"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f8ff67bff0178465a87ca650a6f24b91688514f9405c6bc728ad762651882439"
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
