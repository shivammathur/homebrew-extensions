# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.1.tar.xz"
  version "8.4.0"
  sha256 "94c8a4fd419d45748951fa6d73bd55f6bdf0adaefb8814880a67baa66027311f"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 62
    sha256 cellar: :any,                 arm64_sequoia: "da64123414a6af7d68bf85858be770b3c7f2106659b76568439de2600abcd0fe"
    sha256 cellar: :any,                 arm64_sonoma:  "595373b0109df9079c187f266615e80c3d3d2d6cccc319d9a68b67ea3b39ef45"
    sha256 cellar: :any,                 arm64_ventura: "42e0d51db8bf0b52a07d476a30d26ad0c5b1ddfa2673f85cb938ea3c833ae590"
    sha256 cellar: :any,                 ventura:       "5e4cd20d7a5bd1c6266ffcb9561ed27bbfa28439ae69113a1b525efc52cfbed1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4721f84e52d3e8759dbff0934e456d23680fc3a2f6f2b391efdb47ade6dd0414"
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
