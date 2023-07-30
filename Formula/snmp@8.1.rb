# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.21.tar.xz"
  sha256 "e634a00b0c6a8cd39e840e9fb30b5227b820b7a9ace95b7b001053c1411c4821"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "263221a3e4ad42f2e71b45e785724358a099757b118df421dc38c7bdabd450d6"
    sha256 cellar: :any,                 arm64_big_sur:  "76062fdb08454398e2a9b170287e92011b4a5c4219284c498ff3aaed482f4ed1"
    sha256 cellar: :any,                 ventura:        "2e5974f58268d0006c454842e94f8b05f6fa22c77af57f7abee15e96c62040e1"
    sha256 cellar: :any,                 monterey:       "88f7730d3f0a4c12e659f1dd627cd8b2c80727857af182ac51eaa813da0ce1cf"
    sha256 cellar: :any,                 big_sur:        "b63ced6bb536652413c70840777ef2cc5dc2911f26b01d61d546fbcc5f16fa76"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "010401cb82d61f0f417ea01fece3ff868fe1bd72dbd3afa76251a85a8df2e413"
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
