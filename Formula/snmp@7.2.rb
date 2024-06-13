# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5c72b2e079fff3aadf142a084de94af8133d1c4e.tar.gz"
  version "7.2.34"
  sha256 "a04d562d4ef7ca0ce70209b66519394a26ee3f7187ff652b375d111d34a1fb9f"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "101a54afc61182a48aaa54d59607ca35cc82da1d7e28c541ffeadb379f774319"
    sha256 cellar: :any,                 arm64_ventura:  "4fb61265c2457cc9ffd08f6d92916921ca94e9f0a6f60ad3d6c06941d1f7a3b6"
    sha256 cellar: :any,                 arm64_monterey: "c23d34680a0af05c58a7b8ea71d508fc7e81ed5847fe18e2c4ad7428aefc327f"
    sha256 cellar: :any,                 ventura:        "d234146f4cdce8ce1e6d32ddf66361a2447b7fb7431baa5d2aa63d42e820deba"
    sha256 cellar: :any,                 monterey:       "5b76fdb23c1c63572c7fea60c0a88050621f36aadd5b869143c923f47c5b627e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "892b5729b3546cb86fe04843cfd3ffc79c7991c91a6339ad5415a219a27600c6"
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
