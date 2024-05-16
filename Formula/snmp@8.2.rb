# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.19.tar.xz"
  sha256 "aecd63f3ebea6768997f5c4fccd98acbf897762ed5fc25300e846197a9485c13"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "5667a5ca36be71ba1829a9a688dc9e123d6a2c66f8b33ac2f0c9404e8e5c9e20"
    sha256 cellar: :any,                 arm64_ventura:  "4227c8ce4386482ed61ba56f655ae4badf5c165000bf670bd10630126037e985"
    sha256 cellar: :any,                 arm64_monterey: "e98c98a938cb6b3537ba3bc2b43dac10ac0898f65c7bab2533d1e6b5489eeec9"
    sha256 cellar: :any,                 ventura:        "75d1cf1e7c6bd43d1287cce69e4bbe7e063aaafd80c864d297dec38b218de760"
    sha256 cellar: :any,                 monterey:       "6a53b5cdd6a0f5317822af101565b78ed727ce6fa5936ffb2a101d7aa0d21eec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3220ddde03b74bd62af3d45ee4b03e7941c5560111a8032e8f4078bd9046847e"
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
