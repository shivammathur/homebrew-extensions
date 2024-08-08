# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/ab57e06d1e3481c1fbba19edc429e75634b6da88.tar.gz"
  version "7.1.33"
  sha256 "7ffa8f8d30b31d0632fa1ce26d32cc303607b2f88f5f86778ca366b10db05b5b"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "4a2f7a61dff4edf70932615c90050a66d5fbfda8303212a5a075c76a156caff1"
    sha256 cellar: :any,                 arm64_ventura:  "e2dcb070904afc5cd5140f1a0ef45da8b7a6d51a8a45f574d07eeba549f2b7bf"
    sha256 cellar: :any,                 arm64_monterey: "e14d043ec0158bc94a07aa743a4eedeba1214203a9161d6333d272fc0b0388b9"
    sha256 cellar: :any,                 ventura:        "e1e9fedd642a0f11a6f5aef479b349c281a764170580165a35f94f64209ab2ac"
    sha256 cellar: :any,                 monterey:       "410fad95cfe07c2831d5eb54a38ecb2a143db95c04ad3baa10d4161ed12dbf85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cfd7d855586bb66e61253bebdae7fb20ea99ce23d9296847ac0fd5216b4f78d4"
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
