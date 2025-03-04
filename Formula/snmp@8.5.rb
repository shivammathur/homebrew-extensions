# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/1ae2c871d0b69f8cb460eff0c69191a0bbb1f530.tar.gz?commit=1ae2c871d0b69f8cb460eff0c69191a0bbb1f530"
  version "8.5.0"
  sha256 "9a05794fd58d1db96c3af5d4a12e4d4027155201e330f59a974e8cbdc4d55d99"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_sequoia: "cc2ba9eaa02a614a8218174ed93997c15b1506efb25084bfdc682ee5deed62fc"
    sha256 cellar: :any,                 arm64_sonoma:  "4c4b1c1c1bba9fd8c50a9938bab5ddbf4377ca563d5919575806d11bfcdfa68a"
    sha256 cellar: :any,                 arm64_ventura: "69e9061d6c85aebdc21e9c72ef7d2f4442107433f9da8aa319c0535478645cdc"
    sha256 cellar: :any,                 ventura:       "a160d6018c56ae9649aa18a4075b61fec169cb8e5b228d9457998ef4dbbaafda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "62b91646d2bb859234316368a1c53b1c88facc2dd23b426b8d2650b19e22bf52"
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
