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
    rebuild 37
    sha256 cellar: :any,                 arm64_sonoma:   "0e0190cf944cc89dfc2adce15cf131b73690879cfb157b68da6354a2ea33e294"
    sha256 cellar: :any,                 arm64_ventura:  "885292550dadd70e71aa106aa306ce554ccf5d2f70606e52d5a8732d226a33d1"
    sha256 cellar: :any,                 arm64_monterey: "b35e3af84be89716f25424fe3778db374e6025f007f171b7f7e52c7443c980bd"
    sha256 cellar: :any,                 ventura:        "7e3d65e6ce6420981c513590efdc9922542adba1abba6e7d77f4fc840e420507"
    sha256 cellar: :any,                 monterey:       "99781eba824628a8781e6605209a36fcb24b0e989e55b8568352216c6a3dc3c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "46a25bca2a9e3c6aef9c06e9238ceea9013ddb8022a9b3e305ab283686a469a4"
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
