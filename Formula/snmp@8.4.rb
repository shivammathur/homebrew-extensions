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
    rebuild 28
    sha256 cellar: :any,                 arm64_sonoma:   "d5bcc63b8e7a8fa8086a909c92e6036212b3b5cbebf3499164f717c00f374707"
    sha256 cellar: :any,                 arm64_ventura:  "fbb364636440d2146c13cb0c4c18e59b3ba7174d775e2bb1de75a8b9bb10013e"
    sha256 cellar: :any,                 arm64_monterey: "ba0b9c3fd4786288f8d6da97cdcd6c1367e606ae6ac323a9f47d33692d9c9ac1"
    sha256 cellar: :any,                 ventura:        "ff81747a8938217b51eef2dc60919772ef0b01515d97710d09c63051854a9dfd"
    sha256 cellar: :any,                 monterey:       "d5c78b889f320111f3a9d22ff09e2bc0e7cb3128dd28995cede94a1aff5d3380"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "62c50e0496213e29dbde85a3effc7fd04ce79f5443bc407d4eaf0bfbda276a81"
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
