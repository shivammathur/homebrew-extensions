# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8f4738f41df7d876195449fb7ea83d6ffd700afa.tar.gz?commit=8f4738f41df7d876195449fb7ea83d6ffd700afa"
  version "8.3.0"
  sha256 "af4e1eeabae1bfa72b93cea6fe23de40693259f42a997c713a1ade9cd1a74560"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_monterey: "43d2dcae7291e069ea335d77c5c1b037bb092cd58e9d8abd5c7135f093a1d35f"
    sha256 cellar: :any,                 arm64_big_sur:  "c07c4c0adcb7963f74dda6564338fd988c6561ce4fd5274d68f9ad3b20ee4a26"
    sha256 cellar: :any,                 ventura:        "a6b70b56f34292ac9950cc8dc8d931e6f9c6b7fe6c849b0d0171492192ac1d01"
    sha256 cellar: :any,                 monterey:       "adeee9b528f89dbb7b03b393464cb4b04160a850ca4bd7fe26b8d59fb6301dd4"
    sha256 cellar: :any,                 big_sur:        "986d2c8173a2aa4e97949e62f60b663f9a72c036f8afff3eb0013aa0f63a5763"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d60c7f8d94d11bc50ce0138e882de8f9623218572be9682c9a7f9d65f76fe904"
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
