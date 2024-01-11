# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8d7364f0bbb9a6d53dd812202d11fca2da5f37d8.tar.gz?commit=8d7364f0bbb9a6d53dd812202d11fca2da5f37d8"
  version "8.4.0"
  sha256 "a4b63efb0e1c53d089620c9f42495bfc0f8678fdd8bb2249f03788249bb9e2eb"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 23
    sha256 cellar: :any,                 arm64_sonoma:   "a66772b24ffa90dacf7a70d20f5df3842a51ad8f580ad9230c25b10e6fcead5d"
    sha256 cellar: :any,                 arm64_ventura:  "457a62bdf6d36bea011e8eab334f59cb27cd4aae6337ee8c9ebb283daede0d5c"
    sha256 cellar: :any,                 arm64_monterey: "f2d568dca68c12bfdcf1ce6f6d1019d26115e1572a0a4ba49888ce4013c68156"
    sha256 cellar: :any,                 ventura:        "62e34d6a5ca805d7337e8f30486ba5e82e6aedc9b3f821a7a422d2c8ea8cf380"
    sha256 cellar: :any,                 monterey:       "5d46da6458d90ba473e84f6c52cfe9ec5d8dcc4b3035bf4bb791e87edb6bb812"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f3a8592a8849b670ffba38a8584db344d1ffb12cb141206315d38d1d96a2fb50"
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
