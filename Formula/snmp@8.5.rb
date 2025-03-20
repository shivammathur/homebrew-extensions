# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/b450a9c826e9c5839e3a878f0a07ede745d4ad84.tar.gz?commit=b450a9c826e9c5839e3a878f0a07ede745d4ad84"
  version "8.5.0"
  sha256 "02ffb9f68575906480f621b97a27a8706f4e2c311070df9b4da1dec990214d17"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any,                 arm64_sequoia: "a104d514a45105f64eb61b7a9b7e6a85725dbc2548db63d6382b85a0e81529d7"
    sha256 cellar: :any,                 arm64_sonoma:  "c54ae0f10c916466da77d1ec844ea08e63a75076d2a4bbf7b0f049b28f2d110f"
    sha256 cellar: :any,                 arm64_ventura: "eae92506501be614860deb0897c937e1c47c57447a683aab1ded80288bf62a92"
    sha256 cellar: :any,                 ventura:       "6629f0859fcf92066a48e8dd66a8731695d83b7485c28c37a2c5cd3e7cc56cec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3ca0cff4bcf34efaee3f9f87c791e292014f80ad6fa857f32bed99685b4be067"
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
