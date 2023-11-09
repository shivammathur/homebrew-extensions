# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9717e9fd564deb5a99bf5602c4fd7386ffad45b5.tar.gz?commit=9717e9fd564deb5a99bf5602c4fd7386ffad45b5"
  version "8.3.0"
  sha256 "3e021ea7b341dda41b16f91de1d18d11fbccbceea854e77d2ad8c9f7ce4edf50"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 21
    sha256 cellar: :any,                 arm64_sonoma:   "72252752892fba326f7cd5891511badad7063fb0ee5e752c3a01a2efdefc4ac1"
    sha256 cellar: :any,                 arm64_ventura:  "b0763c63cfe0994e62c5679333c66c72678998674df883137ad29aba544825f7"
    sha256 cellar: :any,                 arm64_monterey: "847a2d31c00b757a55d3f8a664ce8d2b020f0717db1e4b70c4d0728d5466f534"
    sha256 cellar: :any,                 ventura:        "2f53e56492a9854d53e9bcfcc7e4656bc9170ac4282f17cf468eba822142fd11"
    sha256 cellar: :any,                 monterey:       "966b2208e3cdbc4d946304579dcbbce10bb792d6dbc4cc2e4dd5c8474ea52496"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "50becd2a6e522e6fc0d923b3b233758d111ce533fd0d9606f173c2196c68fef4"
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
