# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8fc3615a7a1757953e044682edfad3c99ba5ef02.tar.gz?commit=8fc3615a7a1757953e044682edfad3c99ba5ef02"
  version "8.4.0"
  sha256 "141936e71ab9a7d7509b61d307ca95142cb8246f97ca3583192880dfa6a80140"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sonoma:   "c270bafeae4aedb82af562b4130315f051c267c27567140eb67cd79c0cb8d651"
    sha256 cellar: :any,                 arm64_ventura:  "f9edfa1da7c3fbd05e2a9fe0dc136d2842343fd951441f3efd1f109328254d94"
    sha256 cellar: :any,                 arm64_monterey: "5e0b49a7efddbfee76ee7184d5fae6fcbca0a683f51a20f0d63b2024be582019"
    sha256 cellar: :any,                 ventura:        "e39542c5aeb70c2b299475fa403540c14a3df4aff65d738f5d35fcf3d1624087"
    sha256 cellar: :any,                 monterey:       "c45b82847e9a6c4894794a86dac786c36dccc922bd7de7b39ce4109addd24b4b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "13804cf9918c8abe3f2a38b02af4c948639af8af32b83a0281dbfe93554c3834"
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
