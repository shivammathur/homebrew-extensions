# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6f6fedcb46a27cd3530f0babc9b03ce4598f9eab.tar.gz?commit=6f6fedcb46a27cd3530f0babc9b03ce4598f9eab"
  version "8.3.0"
  sha256 "7c2889c5e12332db85724204c5891a221aa32faa0226078018d752e187f7b413"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "26f1859429c63f5fcd0a9d08f91668ed77d4afc74b796847f1ea5dcde2b623c2"
    sha256 cellar: :any,                 arm64_big_sur:  "41c8ec7a5aec378b2247273c7a3b8be2ef06fe0eef19bbeab4be1afa08292153"
    sha256 cellar: :any,                 ventura:        "6a4a164fc693e791bb514e30444ee0d96635d81b4712814da29a9bd61a1e51d5"
    sha256 cellar: :any,                 monterey:       "fa0c680d35d3fd44acc225633af95c8d3420505d0c1f15f6e061585327df702f"
    sha256 cellar: :any,                 big_sur:        "0d4b61f7ed619ea118ce52cf4bf5d706a25d3b80820467f4c3079acad76ae31a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e552a6479935b0ce60ef1af61680c5f88e2fca956b59d5e7a9997cee28853889"
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
