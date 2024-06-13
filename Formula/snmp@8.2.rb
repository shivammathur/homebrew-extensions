# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.20.tar.xz"
  sha256 "4474cc430febef6de7be958f2c37253e5524d5c5331a7e1765cd2d2234881e50"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "0d558ba98e3febe6d7e7119ba600d2e46e745aa6e7a43bc64d27f1d2abed8216"
    sha256 cellar: :any,                 arm64_ventura:  "f459fa03876ec83da5953316e94be59b925d8aa9ec6d9a0bd5506761fe6f04ad"
    sha256 cellar: :any,                 arm64_monterey: "42a587876e704aed9b297e956937506087819b095ce737aaa2c3edade234eaa2"
    sha256 cellar: :any,                 ventura:        "a66cb2e346a095535d2fb130a98a93e46be338ef282aacaa25dbde4b462165d6"
    sha256 cellar: :any,                 monterey:       "9355c7561169cf3478d1463d02d3d4f156531a883436688132efef26351ba831"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "368731845afd41332550e2ddda56eafd24ac4ca24e625c1784c439a629b69227"
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
