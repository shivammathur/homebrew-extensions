# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.16.tar.xz"
  sha256 "d61f13d96a58b93c39672b58f25e1ee4ce88500f4acb1430cb01a514875c1258"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "0d96136801a633f836e3c35eeadd0196e2afb9e7a4db82035863e61116f76efe"
    sha256 cellar: :any,                 arm64_big_sur:  "25d7075777611e4ac0abddb141a909dcb4fbc42e77bf7ff8bb008474c6541344"
    sha256 cellar: :any,                 monterey:       "4e7cc65daa52385ff789bb14140f71380498515ebfc8ff78886c961166b6c71f"
    sha256 cellar: :any,                 big_sur:        "e33704f5d43a8f24971be2ac761ed4564aca577bb9942200a54b625ceb8da0a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a7a42aa92fad37ee57d746ba722da5b3f3f74fb65f9f7f328daefc68a38d4509"
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
