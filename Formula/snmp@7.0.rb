# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/55d42c0821d426b22eed16e07339fed20cc130ed.tar.gz"
  version "7.0.33"
  sha256 "d8f0f03a149d5534b75c7a144ba06fcf3717a9bed1fb2541e6972534fb15e884"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sonoma:   "c2b0743c9a1650f937b8e30c8ec8ab0525858a4fef72972d3df20ce5e9aef492"
    sha256 cellar: :any,                 arm64_ventura:  "4343a46f581aff64bf8165536df8ab510fed163f492ac4d455c1cea850c181f3"
    sha256 cellar: :any,                 arm64_monterey: "5971c05f6e3abfbf7bec05325d60ba6967ef1f087e5f8ef876478e47a5775d33"
    sha256 cellar: :any,                 ventura:        "9893833e97a9a943e1818f1f2b69ce7625bb15307bf486242a30c2ab6854d93d"
    sha256 cellar: :any,                 monterey:       "c2a616e9ee8b926e4c05ee5f921e15ab8b8255480b6dfd318649a44026f8efca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dd5d0ed5633b686873560181f1e1554f8c0a1376a1661589739e36d6b00cc760"
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
