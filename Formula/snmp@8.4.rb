# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/69d9c12df64e829befd843175bfc9617aabb7450.tar.gz?commit=69d9c12df64e829befd843175bfc9617aabb7450"
  version "8.4.0"
  sha256 "4fbfb690e1929dc5fde726ff07a2b427d1338ca2f1c07deb122a64e4a6694523"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 56
    sha256 cellar: :any,                 arm64_sonoma:   "8b5f7ca1588ad72eece0d8de0360115e676489681551c4de328b76618acf33af"
    sha256 cellar: :any,                 arm64_ventura:  "d660648d2c3fd937c793f2588da50f5bd6690476eb6529982d90c3c29f07c559"
    sha256 cellar: :any,                 arm64_monterey: "b439f3c1e2aaac68b362bb22bef4421ac473377d9115592ca33e48bf4612dff7"
    sha256 cellar: :any,                 ventura:        "77812a8fb296aed430e778900e0497298413d6887e8ddbaea64781939c5c5903"
    sha256 cellar: :any,                 monterey:       "38ec1b780933eaba5d668894b08c586a14a348a9547302ce1bb393fd8b31e27c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6c82b62339fba11d5b14623774529690b2630106e69e54818fe41055a1561c4a"
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
