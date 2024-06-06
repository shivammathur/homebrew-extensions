# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/a372dd10f71f5daebfaafb731b47befb1de4b4a2.tar.gz"
  version "5.6.40"
  sha256 "acc3dd520f6cfb1990514817d7ca69aee2ec99510a7771892f46e2635a83aee6"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sonoma:   "9c9c6ec32a33ad3f9a5ce13ae475023a69f4b73949fc2169001d2c087dfdb9ca"
    sha256 cellar: :any,                 arm64_ventura:  "a662b0de66ffbfde223e8d90d03461520f536b47bdf576fa297725342ce14b70"
    sha256 cellar: :any,                 arm64_monterey: "ed4440b422218cb5f1ca121f604ab3db0d864c35d410a690ad40650352fdfabc"
    sha256 cellar: :any,                 ventura:        "a0c7de23cc101f77a8ca4f5a2eb7b08cdfb441c9be174195273d176ddde2047e"
    sha256 cellar: :any,                 monterey:       "9e3bda36c414e973741617ee631d112ceedc4c955408b13ff20bf3d83296be7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "829e9039e362aac484d5d78e7e54d2396cdd384dad46eb4ca19366ab073c8030"
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
