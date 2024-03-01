# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a74da53fc4b0b075cf762cb37d71b1e22c663c64.tar.gz?commit=a74da53fc4b0b075cf762cb37d71b1e22c663c64"
  version "8.4.0"
  sha256 "f81c0c45824bb2ca2aeb9a3a4a7cdef1fd3e0a5fa775477448aaabed81c9cb91"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 31
    sha256 cellar: :any,                 arm64_sonoma:   "3e788fd44342cf06ed09c8414ee8fec5848b5dd7444696d94d68eed7003cb34e"
    sha256 cellar: :any,                 arm64_ventura:  "450405158f7c1fc2159ad6233b24541af47b33cd0867baffc4d3fef31fa07d46"
    sha256 cellar: :any,                 arm64_monterey: "a7962c795fd97a9126c7d02516175758addcaa929d0a07cb9715baa48c34e8b5"
    sha256 cellar: :any,                 ventura:        "6efbf6714ef829e4c5ce5c71fa1c53b893a945af71f9da9b54dadc367ad464f3"
    sha256 cellar: :any,                 monterey:       "b1680a8ad531b2106059c6f279365f8960906089b6ed3cf8c6ae1f38cfb50811"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "734e72631cf5576a15ad67fc2c945ed32ae9b67d31e06669a163db2ef9125181"
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
