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
    rebuild 5
    sha256 cellar: :any,                 arm64_sonoma:   "3e6937aeb8a359242454aa435daaf66ad7ef8b14a83a262e3c62850c09b06310"
    sha256 cellar: :any,                 arm64_ventura:  "de6c9583b72862393c1de058bef22dda1a6dd80b7b1fbdb070e4ba17421fb528"
    sha256 cellar: :any,                 arm64_monterey: "a59b4148a624dc9cf6e57bb081b26ab6ca0986cb002d5d0f9e54cab0d635d142"
    sha256 cellar: :any,                 ventura:        "2dad1115f11bb740dacdeeed7081ac39797d5aea4e582b8e1b1703ea1f74c925"
    sha256 cellar: :any,                 monterey:       "1b97e80f78d3875b4047a95082a5ac3d7512214906c08ca70636c26cdf816556"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "68f103ac8a73042541b998d347f545fdebb99ae01000ad11caae4d4b67b8a332"
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
