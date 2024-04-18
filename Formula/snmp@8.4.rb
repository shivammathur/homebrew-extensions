# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/e23440e5a64879ba00c8755e24b7a9ce0560fd08.tar.gz?commit=e23440e5a64879ba00c8755e24b7a9ce0560fd08"
  version "8.4.0"
  sha256 "40678e4003df3e5f5b7f675d5cdf2da30b0286730664c9160ea7550c80822d30"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 38
    sha256 cellar: :any,                 arm64_sonoma:   "2844a6c03bc359d385e54bc370bf75e0e65dd86c1cb530b0384cde660b2f9d17"
    sha256 cellar: :any,                 arm64_ventura:  "8eb0dafa227e0da9ce3a1dd52bf40e15ad37ec8f5a83d273836e58f176fbeaa0"
    sha256 cellar: :any,                 arm64_monterey: "6b1d558926ab153e9c75eff1ddfd5949b400530e0abb029ff1eadc396f9f3c52"
    sha256 cellar: :any,                 ventura:        "4622f137e1f74cc9c57551d5bcd1e8164c2256d73319bce61870cc229ca1ae4f"
    sha256 cellar: :any,                 monterey:       "815fb6faa6c15da641a01943f45b8bbaf8e235a029ac3c8d5708f9f5f248a3f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0ed96b01db585f8df2e13b6c00855ca4743fa5e0cce98a6db50cb10e7eb45ce8"
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
