# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/1c9dd35b4ab8c7b42297c7950f9041c3ffd4d172.tar.gz"
  sha256 "c5c64d46f1d150d91bbcf8d36dfc5002c192f1984c42332a81fe10d0fcc52b90"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "b2dfd479f9948e2e0eb34410ac6b486a94580df887d42546325046c897d5f303"
    sha256 cellar: :any,                 arm64_monterey: "0be3b8cd6da390aa37142126c55daf071ce3788de613510c68ba7b2e304c56b8"
    sha256 cellar: :any,                 arm64_big_sur:  "46c28529456637b9b2f6b1b5bfbab4685602fb4962c3e393bf46d1a64a746813"
    sha256 cellar: :any,                 ventura:        "4aa2717c7e807df52d422000564da0614824135e9d7930e36020dee3b8a5b9a5"
    sha256 cellar: :any,                 monterey:       "02fa5d59264f0dfe1f06a1de0905e7dcb4c5a51039db9d603808e2f3c0be4dd0"
    sha256 cellar: :any,                 big_sur:        "c448e1043832858095aef43529a4340d351e46571c52c5c60fda62d5d7473aba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7788b5a3dc51f69a2559fdac593a5901eb18f56dc5ef5ddf251623859747b07d"
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
