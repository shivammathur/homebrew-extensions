# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/bb2ce3eec92a574a46b709ea36604b2564b8c94d.tar.gz"
  version "5.6.40"
  sha256 "85e5ebda9e374c7f2970fb79804858ae30c92913c93520848b8cd2e7571aeb7e"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sonoma:   "684f90fd823d8fe137fec3e3ccf05c965702e841054fba87861b37ffb96d4efe"
    sha256 cellar: :any,                 arm64_ventura:  "55eac32de3552621ce7b234ea441bab04f5aa0344631410338fec9b22d1a0f6f"
    sha256 cellar: :any,                 arm64_monterey: "7e9efa2302c5fd42972f652dad92404de9ed2bb2ce3963fa701e6b3634bee8a6"
    sha256 cellar: :any,                 ventura:        "7e00b5b4a02ee89554f3618df1aad7e9f66646bddb41d0d5ea5e4ff65d833d7d"
    sha256 cellar: :any,                 monterey:       "4f048ff2345d230691b348a5d229fee299527e3f158696c6f102bc43ce3bcf81"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dd9a2cfddd292b9a8f2238815d68ed41afa8bbc47f4d9c87dd56da42beae95ba"
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
