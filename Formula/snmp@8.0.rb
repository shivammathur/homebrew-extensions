# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/31b3988504b443365bfa4881257782b00919a751.tar.gz"
  sha256 "6f0f2a0dbb37e904859d7cc9ac12425434333a5c4b811b674621525430bd5472"
  version "8.0.30"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "99306485dd03109d1dd9a4c3f4303189b5ba39a431ae91ee87742ab3d2e1e37c"
    sha256 cellar: :any,                 arm64_sequoia: "1941a5a1817d0c793a7d27bbcf052ac06055134eb79d119244f31f8714d4c0bb"
    sha256 cellar: :any,                 arm64_sonoma:  "7404c996cd794f2c62201a853cb60864c28fef7b46cf4001c2fac7e4f23529fa"
    sha256 cellar: :any,                 sonoma:        "7312c3c48159591806702fab608da032ae738b22126dadd1b67604f7d166e5a2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "78e2086f896dc94da135369c439819d51384e5327900aa3ea02ac2b023a9c892"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9d749e4a7fd7de52d1f21cf94bb7ebaf90f9a32c9e092f5ec6e572387821cd48"
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
