# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/89c4e4c4cbf14268b71d5a340d50f8e465de2a09.tar.gz?commit=89c4e4c4cbf14268b71d5a340d50f8e465de2a09"
  version "8.4.0"
  sha256 "5c5f2c3500d33ad667e18aa873df389007f56d6779638b3a2df9c7223e3a22ab"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 45
    sha256 cellar: :any,                 arm64_sonoma:   "bbec886f83b3ec39fa262d351c104093500dae7e6d24b39f3af5ab908649269d"
    sha256 cellar: :any,                 arm64_ventura:  "463fa74dc83e8063afdeae1b737b16a88233a147e37e751ee79bacd441b89580"
    sha256 cellar: :any,                 arm64_monterey: "bab064558538bbb525d00228e90d501a434fbaf7bd2f6b55aee9671fac5205b3"
    sha256 cellar: :any,                 ventura:        "8adbca78daf1456ba2059a0ae7045bf3f7d6c856af44fc3459d05ca4ac5fb2e6"
    sha256 cellar: :any,                 monterey:       "8e13c6e8fca7b78e398a6beff95ec62d4a9bfbc23b1abc00c04ee7879d2fac6d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4fdd45345632f9a50436cc33f40bd17b5aa19084d8c174dfc84501e7336d5f1f"
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
