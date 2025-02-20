# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.4.tar.xz"
  version "8.4.0"
  sha256 "05a6c9a2cc894dd8be719ecab221b311886d5e0c02cb6fac648dd9b3459681ac"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 64
    sha256 cellar: :any,                 arm64_sequoia: "f3f7645ca812061c23b482dd3d3347969aa0227c80792d6ae78c05e841fbc3c8"
    sha256 cellar: :any,                 arm64_sonoma:  "ffdcf3b93149322a94f96ca86f87c9d5116cacc7d2e1c05bc3b1359082365a83"
    sha256 cellar: :any,                 arm64_ventura: "f15c7d5ce660329392490ba5b4696357cb3580e0616de88ca45762e7ea4922ff"
    sha256 cellar: :any,                 ventura:       "5cad26e626c32b67b4750e9f0bdf4e679f66e9ac2fa5839e7e753ef11a3ad9f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "45ba399bc6d88153168af4e2b684b3bc8621583692fe0b0d93672058abeef43c"
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
