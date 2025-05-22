# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/16a3fb1c3fbcdecbb4da8f726285baa659f08e93.tar.gz?commit=16a3fb1c3fbcdecbb4da8f726285baa659f08e93"
  version "8.5.0"
  sha256 "99f939d56a5b2db389122d0d93665fee289700c62ab50c256c32e1cb8ae379e1"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 25
    sha256 cellar: :any,                 arm64_sequoia: "eaa4c0c3ba8e89462061b77ed41abf58a151d21eaff3201d4e8e8500be0a769d"
    sha256 cellar: :any,                 arm64_sonoma:  "5f5059fb6c6031331483a6403792c8c733c3ed6617e8a2bb2284702c087c1a83"
    sha256 cellar: :any,                 arm64_ventura: "947c24c7f0167fa4567e2a2202e7e5d1628d77f659e41414343f95d8780e9805"
    sha256 cellar: :any,                 ventura:       "8b376ac88160757c323d4474888d5492f0861509844111d1b8f28ea5556a7b7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1199d86967112f041a840da43dfdba42ab4287819caf150ec139a96247f89247"
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
