# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/378b015360db45286b53b86181faf38ec504bc3c.tar.gz?commit=378b015360db45286b53b86181faf38ec504bc3c"
  version "8.4.0"
  sha256 "b20f67106c297e0acf3dd0041cb81d29977d4329a2a8ac5b8870ade53fba72c4"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 39
    sha256 cellar: :any,                 arm64_sonoma:   "4144505be54620d5996938acb26e696cc21d453451186e11d884d06ae4948b9d"
    sha256 cellar: :any,                 arm64_ventura:  "a20be03afdc47fbf641c599e3bbaa6b03708080d600e18310ce9677b09b94866"
    sha256 cellar: :any,                 arm64_monterey: "d4ccb56195ba7a68332ca7a4835b98cda72088c0b5b5b37e0a0c62b1cfde69dc"
    sha256 cellar: :any,                 ventura:        "13353198168e5e4fdfdb2ca56e7b170a5d3b99680a3a8d51a9becb1c11d08f75"
    sha256 cellar: :any,                 monterey:       "ad98de16603896db7712765362f0cebd04fc1d83cc0f6ce958ef3b0db673696a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7d86021aad82e7e2a48e50551cb609d642e75456f157777322898a250983b600"
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
