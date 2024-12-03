# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.14.tar.xz"
  sha256 "58b4cb9019bf70c0cbcdb814c7df79b9065059d14cf7dbf48d971f8e56ae9be7"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "e3c046837eacf067d84984140bef5e1f1403f68a354931e6f208c547f893ece0"
    sha256 cellar: :any,                 arm64_sonoma:  "999ecc6b57bb456ee6a689e5648ed2f300f2e2a93636d6217dcf5867c298aaf2"
    sha256 cellar: :any,                 arm64_ventura: "291edf7b224ef15551b5d420d3efdf1e8b17664f2097ba7de4243abef5d99a8f"
    sha256 cellar: :any,                 ventura:       "b8fe2be8b455ce34ed1c06ae6bc00f8aa8e192c357313b3e562f7225792a1eed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2e80bf970402ba44fe1ee72fae447979b33bb7e365084ec66c6879672bfd1d40"
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
