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
    sha256 cellar: :any,                 arm64_sonoma:   "dd12b9ec4172013cbd31293bd5f6ef4300cd6a302a4943a699ab205e31810325"
    sha256 cellar: :any,                 arm64_ventura:  "09afdc52f598480cf778dc0163c25e7a50ac54adfea36bf758e5d74d395d6c31"
    sha256 cellar: :any,                 arm64_monterey: "aeca358dda844192ba9757ba514744df2f3a7e0a8cd564ef4d1741f6b1d1808c"
    sha256 cellar: :any,                 ventura:        "ef5a1d48883571394584cafbf7646c9f561ae132ce955d285ecf4baf90ea05f3"
    sha256 cellar: :any,                 monterey:       "08495225cb53daadd1606115b28153f16cfe192d4d03d3fc22949c97c51ac315"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f9523a024330a2e7cb4a7f2ab6e95518886ef5bfef39a573cdaf12b4e2b00d7c"
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
