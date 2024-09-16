# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.23.tar.xz"
  sha256 "81c5ae6ba44e262a076349ee54a2e468638a4571085d80bff37f6fd308e1d8d5"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "431747f41dc817cd4291a0a930566ab02d541e24d042fffc1ba95b917ae8af2f"
    sha256 cellar: :any,                 arm64_sonoma:   "1abc9374efdfc3f6aef4092453e2c934a2182d4d43937fe15b14ce23fb8c2a7e"
    sha256 cellar: :any,                 arm64_ventura:  "54c3918b4cc270ef5ca9e10bcad87cd1492dab498abd412e7ba9de439ef05bed"
    sha256 cellar: :any,                 arm64_monterey: "ca8d6ac2ddb94f2bc1727f1b5f6a6d7e4eecd98165edadc5ad60b993a4c585d5"
    sha256 cellar: :any,                 ventura:        "32eb50b1d6266cc312853ef0b8962d32ab433f86f8768ff00947c72991648729"
    sha256 cellar: :any,                 monterey:       "81f9e1306d87151cfeb006a6e0edcaca53019b8a2615a65718b1134f3ee80c1a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7cb3883b79bdd3d39a4256e9a6676337e62cd6e4689e939e1969182c52b48817"
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
