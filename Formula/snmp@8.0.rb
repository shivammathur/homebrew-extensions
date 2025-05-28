# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/a53a915ae43fd8b5c06b19742ea33b3d4bcea6d1.tar.gz"
  sha256 "f3248c57ec0706edab825e00194b2408b11e5fb50bb7cfe9ad098f34f83debdc"
  version "8.0.30"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia: "c4e9798cdd38570db0b8dfa0030692a912122f435ca5ac489704353f5ef7916f"
    sha256 cellar: :any,                 arm64_sonoma:  "d97bd6d5c5bc6a236ff55fdac2ae91102f23f251053dbf8395a7dcfdd54cfbe3"
    sha256 cellar: :any,                 arm64_ventura: "b28f7f37b5cd7549d28b31adb29cf94f84c03fff32b39a04479494c51b0cc506"
    sha256 cellar: :any,                 ventura:       "36fb0d79026013a5c3455503ce3f8cd0ada91ef4100b0756a7d2e13e4b3ac7fc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "af074686d2bed358d3a5ca351f02099e2280e70830a5b5ac0cb62a83b1d79bd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5fc84ec38c645d05656ddc2b69ee74f83b64a72cf13794f60991b6c169723a6a"
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
