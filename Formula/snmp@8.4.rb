# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/ead679ecf8daf91840ec9324aa4b4814a3c445ab.tar.gz?commit=ead679ecf8daf91840ec9324aa4b4814a3c445ab"
  version "8.4.0"
  sha256 "c1ef4faba8a1a582b33f2d4b7c88a15ae08620ed46825a84c61e7c2f08373872"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 50
    sha256 cellar: :any,                 arm64_sonoma:   "4cdefe0b4253cf0173573510a03ff9471c30111840e42201ad5e950aa0880835"
    sha256 cellar: :any,                 arm64_ventura:  "d713edee520fd00f93801ad75bb2a4dd74669e2fc093cbf88118f4b91ce6c52f"
    sha256 cellar: :any,                 arm64_monterey: "6334a11bf848e944c271b6280009711615530ceb51e8b60bf1c6fffade3fe6bf"
    sha256 cellar: :any,                 ventura:        "3423f81ce0f518977cd4189485d31957cb05ce90ef31a83df316e547a430036c"
    sha256 cellar: :any,                 monterey:       "95bfc2b1db51ed6e16c59dde62359cd1862e305d9ed01bcc73b970e38166ecee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4166b20c5e400eb397a5053af8c784a199c1fcac4ada1d8422b4df0f6f3d4ef2"
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
