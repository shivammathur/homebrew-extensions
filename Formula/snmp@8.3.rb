# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/278a57f95a30253d2a462baca43144f4dabad4c6.tar.gz?commit=278a57f95a30253d2a462baca43144f4dabad4c6"
  version "8.3.0"
  sha256 "b766d16e282187fb57827a1d06498ae00ae9243612cc533163d6506f009c32c2"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "b2c9e5c98f68b04c779b4c6fef33086e6d0acb429a5752b148560df5664a5de1"
    sha256 cellar: :any,                 arm64_big_sur:  "042f45edb41a193f93ae5a0aefb83f3c20284c0cebf9b9c324b4b008d1bd045c"
    sha256 cellar: :any,                 ventura:        "b115b85cda25f4d6e316dfed90731ed5ab0b3c1c435ee2a4473a763b8628c4f9"
    sha256 cellar: :any,                 monterey:       "ce5b4dc06df2a6552181cdc9d697457e2b09b3aa387983f3d32796c4011e547a"
    sha256 cellar: :any,                 big_sur:        "d97ae8900fb4d9c6cd2e74eb00a45b83892fcb7e99cd8b4daf2724ae27b5ecaa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6389527d17a8c8095972c0b87ea609a369ec90c79f9493ca06d29dd94a0838c"
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
