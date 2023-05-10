# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.6.tar.xz"
  sha256 "10b796f0ed45574229851212b30a596a76e70ae365322bcaaaf9c00fa7d58cca"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "5a8b40bd469f335d68ed6f70c3abd18dd4d8b4af93ff680dba12c605b66f1539"
    sha256 cellar: :any,                 arm64_big_sur:  "890a26eb2866e1bd23fa90cf8280152a6e6ce92796c07466ec83c65c7a17df3e"
    sha256 cellar: :any,                 ventura:        "b9e910173f633e918644826a7c628f0a712f9ab5b47e19fde84f00573e3937da"
    sha256 cellar: :any,                 monterey:       "c69e02eed32cb6d25d375b1d298f141bde4e982a0062b1f6e835024b42290c13"
    sha256 cellar: :any,                 big_sur:        "8e722e3d76d919d23cd9f8434f8e13fd7f1a20243cf6dca3ee82dfc4990d0268"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fb7a994022952157ef30c175069a2b0c9ad51161600165c46d1459e6d23a9bf4"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
