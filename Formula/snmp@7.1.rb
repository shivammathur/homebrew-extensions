# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/dc8d6277d12d445642139b8a7c104898a5a80f80.tar.gz"
  version "7.1.33"
  sha256 "3e7a3342f58ca8698635631993a91541d88e7ddf3335e15194d23dafd5bae409"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "d2abc7324767d1e453e79ee4e7a0bf56c2696a93277fcc241c7d12e50be48be6"
    sha256 cellar: :any,                 arm64_sonoma:  "ad2b98aa25fea3b6a27d7a8f328c59a9e06a5c532d7a6ab4e3a9c96a368aad93"
    sha256 cellar: :any,                 arm64_ventura: "882a5179a5109aa082cd65546ebd42f7ee72c531a34fe0847534a4354902972a"
    sha256 cellar: :any,                 ventura:       "e67d38c563ed10079b082e23272c9c74f1eed8201d2dca716ac086ad6491c94b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "324df7e887c1cee56aba3e9acd80804c6acd50316c5e20e18e476974f6051096"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

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
