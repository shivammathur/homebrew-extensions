# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/0d68e03d05a315933e1726818ddc819454154f5d.tar.gz"
  version "7.3.33"
  sha256 "c74657378e0db2802f6dba6e8366a6e5decceb30ee37fbc955f2a67a09984722"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sonoma:   "0849de3727e2692fd032caba6485198334118606a7b0a85109c8ea6ee348a59e"
    sha256 cellar: :any,                 arm64_ventura:  "9272dbb8eb88904ebc0332b28e59e020d2f57b93c0a0821a6f2b2e03e02eb7eb"
    sha256 cellar: :any,                 arm64_monterey: "31713eb30e050479d2b6351aeeed1f925fbecf3777ff18dae4cc3494613e3679"
    sha256 cellar: :any,                 ventura:        "9c98163cca96a37642a8ddf405b8a69ebdd8f694c5eae644bdc606f7679b6d39"
    sha256 cellar: :any,                 monterey:       "9358a4f01c488334cc5bbfdeecb75c7facc60684d448b08446acaa262ff1476b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1b2f357bf29bb5059d4f9e16c4168555bbcee2ce921e046639d7c9e32f154615"
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
