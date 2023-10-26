# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a64b48ba92182136dfa13ff944bc0942b97d5977.tar.gz?commit=a64b48ba92182136dfa13ff944bc0942b97d5977"
  version "8.3.0"
  sha256 "d9bdebea514a5f07a894c2edeba4bdeeec6231cfb7f891e62081983ce1a1218d"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 cellar: :any,                 arm64_sonoma:   "a6e7099f8b917f5425aab0fac33de4b6cce6af16bc9c691b8c52682b1b5ee3c4"
    sha256 cellar: :any,                 arm64_ventura:  "2812ea9d3d4970577a0b6331cbb7347a4c555a616700faf186b5dc9a8d9888ad"
    sha256 cellar: :any,                 arm64_monterey: "898d4160833c7bfe9031e1ecf5cef65b454bfccf938499197e5a6c1a68d2b7e8"
    sha256 cellar: :any,                 ventura:        "8e058f419574886f614e4c1ea4595637f1e1d00974e8ae6b1ba141a3581ddfa3"
    sha256 cellar: :any,                 monterey:       "1e50a26056d52069446cec89efa2adf9b88259ae0f052ec94cd590007ccb385c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "46a8bb68a8c36feee45d9510507e9761465c7f3095077da04999a13b61a67020"
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
