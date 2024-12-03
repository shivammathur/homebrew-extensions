# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e62bf3dbf92627e79283013f6e83f7a4e5ab3e6f.tar.gz"
  sha256 "0ade4ad72b41f3e1c05e001dd3cccb52800eac770f5bbb9472674bc1fa90920d"
  version "8.0.30"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "339f3f84264187f3c2ebfc76e39ccf814868e459c54adaeb0ff8e09a8ad7cd91"
    sha256 cellar: :any,                 arm64_sonoma:  "6ab0e092954e58754e682d4b5e39d26b6414f41a25f6a91c572db63a668a3b6c"
    sha256 cellar: :any,                 arm64_ventura: "3d27345f114ac1e25c8fb57b136e24af4d96cb859c5a51d109b878c374080e17"
    sha256 cellar: :any,                 ventura:       "4cde5a327d605eb21b16c42e8a8ba13365179395b91d2d264e6cd280096ed968"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "82366dd0ee8b092ce8f32b69d73ec2afe7d40f8498a1218c323e602104cadeba"
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
