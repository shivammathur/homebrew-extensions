# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/b1841fdfa22a7cc0aaff73a84398f5becc8c43e2.tar.gz?commit=b1841fdfa22a7cc0aaff73a84398f5becc8c43e2"
  version "8.5.0"
  sha256 "e19794f9f0331d6858ca6bf835f095d96d33dcd6528e5933689096ca00a59034"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "92fb71e49f83b001132f4e177c385b69255ae0694685483c645cf36a00c7e8fc"
    sha256 cellar: :any,                 arm64_sonoma:  "dbff7f177343fee56ed6b43c765fced97cab0be8ecc840cc9c320dcb1458544c"
    sha256 cellar: :any,                 arm64_ventura: "618f13d78df16e39ae4541bcd98f28a204aeecf7352a9222303294030731df47"
    sha256 cellar: :any,                 ventura:       "5ad74a819abba2a91aa6debd28765937a8587e697b345d0a2880c55d9a65c951"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "97167d0b5faee973e988d9d19a2fc82335233a3b5e1c0f74c2b7d790fe06e9fb"
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
