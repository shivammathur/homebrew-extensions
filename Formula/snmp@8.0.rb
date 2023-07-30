# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.29.tar.xz"
  sha256 "14db2fbf26c07d0eb2c9fab25dbde7e27726a3e88452cca671f0896bbb683ca9"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "ad812e9aebb8bbec190af9161541b3e640b720c33dbb2a992800cd9be287c70b"
    sha256 cellar: :any,                 arm64_big_sur:  "07a08c026bbb7a23fc571179a87b6523555455b46b68f48b155456e64f7a35cb"
    sha256 cellar: :any,                 ventura:        "a137af4c3d635169fe5731d285a346aa4055d4a108353f5b6196259416b85815"
    sha256 cellar: :any,                 monterey:       "c694ea805917239c4b99b28555e0c9fbf09b645296565004434c94085339f9ab"
    sha256 cellar: :any,                 big_sur:        "d52685a8e54eb23df90e06d0fc0bea18012d6330f48b11823afeb8b27af0459a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "acae052242404b7d9b923fcf7f96fe55981d812624c02360c6b62743d2eb5994"
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
