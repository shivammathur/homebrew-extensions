# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.23.tar.xz"
  sha256 "fc48422fa7e75bb45916fc192a9f9728cb38bb2b5858572c51ea15825326360c"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "645491d9a721428f7e6615f3d7f6226c43e805155209d54564d7a831186b6651"
    sha256 cellar: :any,                 arm64_monterey: "6e3ea92c46399ac54b6439bf406f2b672d7277137837ef35337ab6ee1c08e3f0"
    sha256 cellar: :any,                 arm64_big_sur:  "fa6b1b5cb52a22002df60686ea2a794b221327e033592f6836282ad5b8ca86ba"
    sha256 cellar: :any,                 ventura:        "dfe2620bb7e4259ff299531670bf622108ca6a712f4d122c389d58f4909c028a"
    sha256 cellar: :any,                 monterey:       "2762166a0a8c0318be52e01033c290b332a7f46dd9e5fbf22e2efb67b11f5cae"
    sha256 cellar: :any,                 big_sur:        "e49d62984358e6520f3f30bed7431f66c118e26b355c7a898d21ad9c7bde465f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "60515a153215bdbeb568aa234b00360959dca229a800a5640f30f3e4fce02802"
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
