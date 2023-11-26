# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.13.tar.xz"
  sha256 "2629bba10117bf78912068a230c68a8fd09b7740267bd8ebd3cfce91515d454b"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "e5884a046ac0d64d68c5abcd52b291385d9f66539419642d92f9f9daf5c01687"
    sha256 cellar: :any,                 arm64_ventura:  "d2327ea042d3bc36a33a425f8ca4b4f6dcad26d431fa5f615441c4cf4706db5f"
    sha256 cellar: :any,                 arm64_monterey: "32e3faf2c83aeb664814d413c8aeac80deb4f4d5dc7b6256cd12da439a8996a0"
    sha256 cellar: :any,                 ventura:        "11ed28ae796faaa4018eeaa66edc5c0ee79b8a1dbce0dd672b41d4be75ae5bd1"
    sha256 cellar: :any,                 monterey:       "4625ca8be01f729c4eb8ccb845e86f4ed2d8725920a00580b2d72e489554303b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dbffd7616562a76ffb3e44b3a608655f40b9ccb470dc2e90b81914a32e384b8d"
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
