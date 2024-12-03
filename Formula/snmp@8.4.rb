# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.1.tar.xz"
  version "8.4.0"
  sha256 "94c8a4fd419d45748951fa6d73bd55f6bdf0adaefb8814880a67baa66027311f"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 61
    sha256 cellar: :any,                 arm64_sequoia: "3368ca87993fbb3f41a127ec1b1f2390ec7035cf7fbe41d1b4a663a265be35d6"
    sha256 cellar: :any,                 arm64_sonoma:  "d7d0aeea9c2717888a151337d6dcf6b1f601facad3b4cb3e425b384058fe5dc5"
    sha256 cellar: :any,                 arm64_ventura: "9a076b2febdb42fa375b34b1bb62a306f2d6dd804c34b9ce8dc4b42558e901b0"
    sha256 cellar: :any,                 ventura:       "2ceb539e53c42a32cdc82afb309bc70e35b28f92e8f97a8371466b4683673276"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b682cce1d1928768990a1620058921e22fb45490a8e9dda3f897730bd8014d90"
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
