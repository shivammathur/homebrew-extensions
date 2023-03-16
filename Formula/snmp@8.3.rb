# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3a9a950472862f6647e9da2ee056df3100697187.tar.gz?commit=3a9a950472862f6647e9da2ee056df3100697187"
  version "8.3.0"
  sha256 "ab1009f61a47b8c0bfff7748a2da97b80e2278db2da2ce4d4b5973085f6e4619"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "e10c3cb2bd87a7be97412d8bf301447f7f190900ecc61a5618ab61f08d7b46d7"
    sha256 cellar: :any,                 arm64_big_sur:  "71ac2f1d535fd4e45b26de01f1435f6e5d689c9739f09fd27eba9f136aa5fa98"
    sha256 cellar: :any,                 monterey:       "f8b859a85c8070224ab3b6007ab77edf56f48618fdd966b28431c8669bee15c3"
    sha256 cellar: :any,                 big_sur:        "57837ca9d52abb0e09aa0b008650b42504b2fa00551eb7f68e795fd6a1b90c01"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e2c2ba3a6ef39b76c5f2e5a2d8b9413f2bbafd71ddbac5a715b080cd31be8a04"
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
