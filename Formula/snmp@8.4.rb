# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f612a72de4cc269f872816d1e422c228aab41274.tar.gz?commit=f612a72de4cc269f872816d1e422c228aab41274"
  version "8.4.0"
  sha256 "585dda81e68a5e4911c9943624258c47fbece9847b412fa8dafcbdd0a26339bb"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "b9c0491eaafa3ae11edca5a5201067687e6f45f69e63082ae69a5c20464380c2"
    sha256 cellar: :any,                 arm64_big_sur:  "8dbe1bd9971eceae94e734f0ba6953fb88633f49da9dec719837716e2d176788"
    sha256 cellar: :any,                 ventura:        "25ff9f74aea06923697aa5fd44f647708f2c369000acb77c4ef39ed8b22bd26c"
    sha256 cellar: :any,                 monterey:       "39730bde48455dfc8f97ae53bf6331005b9258533278124232783fe4ec96ad15"
    sha256 cellar: :any,                 big_sur:        "1956a0100525ecc3d88f39ff89be7b27219b61bc449bad9819f60a303d50aa85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a627e8d666eeda837632e7383b1efc537e115e5cc0314166e748fdae1b7deb63"
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
