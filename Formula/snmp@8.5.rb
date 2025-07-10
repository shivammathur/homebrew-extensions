# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/64e2832bc8065f24c4d273075608f33826c71fd8.tar.gz?commit=64e2832bc8065f24c4d273075608f33826c71fd8"
  version "8.5.0"
  sha256 "2597fb8c29bc4532c34180c5bd61a12bac3b3e5dc0ceeaaf7ebd0b6818228ffe"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 33
    sha256 cellar: :any,                 arm64_sequoia: "59cd46a65ca2c27bb4553ef7efe83ab6c39a8ed7f3ff637deb4928c3337a864c"
    sha256 cellar: :any,                 arm64_sonoma:  "4610c2a2e95788d8b57813400dff996cb6bbbfcca3fc7a10f2dc76203d680a9b"
    sha256 cellar: :any,                 arm64_ventura: "441aac3ba5e80f0f28582d2f4904ec386e7d1055647664e6637efbc94544bd05"
    sha256 cellar: :any,                 ventura:       "2af3d14254d638b06e6ac1a986317ed4f55315fd24abbf702011a8db3818fd08"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "adaec51626a7dd9bf4ed25ea20d858aa6c906e52b9b1dcd88475cabd3ed22790"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f01e2484fcaec315bf1d0616e55017ba8fae29b321e2d1fb47fb21db2b0c4e33"
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
