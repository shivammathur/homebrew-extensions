# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/1ca91c2bd84fd6596460eacd541c0867b523d73b.tar.gz"
  version "7.0.33"
  sha256 "f198b54226f4c3e0b24d8e4b50e748e1fdf92c41db3cb01c6ff3c2287ee61612"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_sonoma:   "2f1febb53c9572edeb7a5208ecedb4957795da9f3c10dd101bc51a54d2287245"
    sha256 cellar: :any,                 arm64_ventura:  "03225e85e5d38fd6d308c2b3789a2cddaeba6b3cf55ec444141d1666c6571c7f"
    sha256 cellar: :any,                 arm64_monterey: "19391622dc7582ecba3931dc92b4c1c6de85ee9b38143667f175dd932b240d79"
    sha256 cellar: :any,                 ventura:        "d3d47380c378795904884b663c4bb1f287384005449312b88a0b87ec8665244c"
    sha256 cellar: :any,                 monterey:       "d0ee75edf0793439de1c2241169d3c3ffec7b947b1fbc83ac0c6fa096cb962b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "85d0c7eadceed71f0db5f6e8b9e8f312e1ba655b24bcb99183c220851ba85395"
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
