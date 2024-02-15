# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/115c60e0bbe0dbe1c0b11db7bf50cf23695f14dd.tar.gz?commit=115c60e0bbe0dbe1c0b11db7bf50cf23695f14dd"
  version "8.4.0"
  sha256 "257b661e7935b2db881ce71cd8a957d137fc7c680e967023649c2cb09684c048"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 27
    sha256 cellar: :any,                 arm64_sonoma:   "77ba2166e79c8b9760aba93a93eadbdb8a8f55c06aff7d668d66850c89e8980f"
    sha256 cellar: :any,                 arm64_ventura:  "c99b31b274807642807da9cf6975f08e1cab9b82b8685460ddac34a753d7f064"
    sha256 cellar: :any,                 arm64_monterey: "070f636f208a9ed33d10ee06015f98e7cd938ff53a0676caaed5a29de6ace7a0"
    sha256 cellar: :any,                 ventura:        "e3fc45f0a45d76340de35f44dfd43cbbefc391d4cf97e39cc1ecca9a1917cba5"
    sha256 cellar: :any,                 monterey:       "a0ac9ca92c2b5d25df56e7900d7d1a36788b744ddf9beab723a54e10a37138ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a6d5636a98081591319c5ddd5571b1f14d818d01eeb8b48e4ffa877a38e45f35"
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
