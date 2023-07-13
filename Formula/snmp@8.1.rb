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
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "9bdc63da8acf3f0fb8064932119152a99ec69dae2c8385c3d6d02c0378463ab5"
    sha256 cellar: :any,                 arm64_big_sur:  "d5eb538c8b368ef16a80f6c6fda6b033dc795130570b45275ec88742388080ba"
    sha256 cellar: :any,                 ventura:        "54e5347f2f29c3c4d19eaef4f36a4711efde35ee2d99827a52d5371645b3a03c"
    sha256 cellar: :any,                 monterey:       "a98afefb28aa55420e52f3ad923d7b4f3675d3e9c1608292b44f0cd63ddd0f85"
    sha256 cellar: :any,                 big_sur:        "07ebdafdebe360ac1ef3fb9cf817dbab92b04f56503eac4e292b83ad2f0a8dd7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3aa8076ac179139cdfedd30e0e2f42ea9f005720f387aa94d2ad48dca7576a2c"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
