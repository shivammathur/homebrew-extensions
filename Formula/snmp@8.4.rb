# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7278364f9c28348ccf372e57856dc3ba6c46fac9.tar.gz?commit=7278364f9c28348ccf372e57856dc3ba6c46fac9"
  version "8.4.0"
  sha256 "f16b8dc32bda8b9be457e3bdeb7bc49e7f449caf46d0c6ac71629262789e86d4"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 44
    sha256 cellar: :any,                 arm64_sonoma:   "56adb271461a4c67d69dc5f47d316774c9b87009508af1e244b8b28d1f4d35d3"
    sha256 cellar: :any,                 arm64_ventura:  "e719eeddb7cb9374a3d88d144c2889b3db181e16ccd7ad173801704544609904"
    sha256 cellar: :any,                 arm64_monterey: "9254ddcebb7144fb01074d0d819fa9608f375acd45d7c396dcfd9f79bd68723c"
    sha256 cellar: :any,                 ventura:        "7d658bb8ff726a4bd1397a7dcea358d21693ab637b74e2cfee5624d275459242"
    sha256 cellar: :any,                 monterey:       "da5e315efecb2b3b3b01200914a4548cca7fe0745fe256b35074cc161405c1f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "97c0ad33647771f443382ff25af40bc4c436c7205e6d1282b4e81fe6bf605e3a"
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
