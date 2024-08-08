# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.22.tar.xz"
  sha256 "8566229bc88ad1f4aadc10700ab5fbcec81587c748999d985f11cf3b745462df"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "816f203b80c80a1fc13a235d74ad33f3807522c515a5e6df272ef952e278a032"
    sha256 cellar: :any,                 arm64_ventura:  "580112377ea627e426c659185eb7664e281cb899ec3edb7adce2809a6558aaa4"
    sha256 cellar: :any,                 arm64_monterey: "372319bf569707e00b81c64d390d0ad01d455ea5680406f50fbaf4f226d93d87"
    sha256 cellar: :any,                 ventura:        "69a63681e2f1b6d21868b161c46aebe05794809c7a7f70db43e88524e639dd3a"
    sha256 cellar: :any,                 monterey:       "6ccc822155b8ea5435a70271affe8002cffb732de69cb2b66e61fc1375c1326d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9cc82027d573bed311b00db7b11d95079b09b2ab04e42a3360ce02581a76c430"
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
