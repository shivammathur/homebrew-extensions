# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.14.tar.xz"
  sha256 "763ecd39fcf51c3815af6ef6e43fa9aa0d0bd8e5a615009e5f4780c92705f583"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "49bf037d5fc2d5fc0f846c5957ab7b3bd844765eee965c128dfc4e8cbbf71d66"
    sha256 cellar: :any,                 arm64_ventura:  "d5b5898848c6c200651ff9b13d5ad004a97cc5174b9c532b6f520a819a7e9b78"
    sha256 cellar: :any,                 arm64_monterey: "ab0ff224dfa2da48482da99631d720f5bbfe80cb3674c2ee8775264193f3e06a"
    sha256 cellar: :any,                 ventura:        "3369849c6e323f6ddf82ff639bb56ca31b310479c177ea067405a3a0bdef0fe3"
    sha256 cellar: :any,                 monterey:       "bf8f0573e8cfb70fcc2776cea47367933571fefd61acf15881f313dfab2ee13a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "272aa76880704cbc3275fee7dea594f1e7619f43ce642518eff2d41392ad42a4"
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
