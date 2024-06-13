# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5c72b2e079fff3aadf142a084de94af8133d1c4e.tar.gz"
  version "7.2.34"
  sha256 "a04d562d4ef7ca0ce70209b66519394a26ee3f7187ff652b375d111d34a1fb9f"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "4db100f04df7134c609c392b3c582603029d28547ab88cc20e7a2adf02aa91e9"
    sha256 cellar: :any,                 arm64_ventura:  "39dc0d53a29d1b1520dda76dc8640150df5420732799660bb8be2f3bca932e90"
    sha256 cellar: :any,                 arm64_monterey: "20387e06108e85b6e06c1e03d4efff150b794d44ec39939acce07b8ca162c477"
    sha256 cellar: :any,                 ventura:        "beda55bff5dbb4853218efb95b22acbe006b93b8900cbe7a83e5386230c45099"
    sha256 cellar: :any,                 monterey:       "de5c161553ca3f2f0b4a1577f85c0b04a2d1027c753128fdec4879888558e52d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "381e30358fc3ab7822c58534b027ddb641d255b351329cafeecb60ba785ca394"
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
