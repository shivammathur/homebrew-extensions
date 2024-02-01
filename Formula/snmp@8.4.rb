# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/c8c9fc3f69b789faaccf7853aabfdf15a9452ad3.tar.gz?commit=c8c9fc3f69b789faaccf7853aabfdf15a9452ad3"
  version "8.4.0"
  sha256 "ed5cbff0628a5baf2d50f61eafa6c94148b6e848be040b80d1b62c3346691445"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 25
    sha256 cellar: :any,                 arm64_sonoma:   "e0c960450f5bf70095096247f16a22d121f209691bfd7093f882c11cef12343a"
    sha256 cellar: :any,                 arm64_ventura:  "4f06e16ee36dd693d64d9ec5fe5275d556b43e927119a4d5a5524f308e39392b"
    sha256 cellar: :any,                 arm64_monterey: "7069cfa2711e68bf6ab7b1088b28c8a835d10e74fc55c8c40be7e7e9120a7b31"
    sha256 cellar: :any,                 ventura:        "b9f808bd198f88aabee487c35acef1ef67ccb4da235156f96c126b323d906fc5"
    sha256 cellar: :any,                 monterey:       "a67a1bbc915ceae6d442ff6391ffab96ca3434875ec41def6d680ac0bbfffee7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a23515d7eb89b87db43bb8a5e777de34e018a9748074f7091a78859b457fc214"
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
