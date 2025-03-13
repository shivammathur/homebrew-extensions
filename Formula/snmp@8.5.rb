# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7faa3decd90a4cc020fc969a04ae49f542090f35.tar.gz?commit=7faa3decd90a4cc020fc969a04ae49f542090f35"
  version "8.5.0"
  sha256 "3e8c58c59f59bd8d405c8d18ab704f9765f644079f682f95d63c95092df8e862"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any,                 arm64_sequoia: "f9c4775a7842549fad2f653808dfd465b6d7d4f0a706b78bcf9632ede0f903a2"
    sha256 cellar: :any,                 arm64_sonoma:  "7aa4a013ae5cb868c88e73f63ae2158b7f22bd4ff9cd7351658de8031e2ea789"
    sha256 cellar: :any,                 arm64_ventura: "6776595f6949dac1fe392f6915b13a4e04cadf3e9174ccba1a2d3e07b0947604"
    sha256 cellar: :any,                 ventura:       "069d1aeea24f0b3c6319352e467ba852d4b1cb925f7a92b86702b9b17ca811f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "586941651ede9ea5015a451d47c42c78020fae2f6d134784973b96004bd9c2f7"
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
