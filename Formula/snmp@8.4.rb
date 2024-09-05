# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9b7dac4532375820e33d4c6e0af61fc8fe0aba16.tar.gz?commit=9b7dac4532375820e33d4c6e0af61fc8fe0aba16"
  version "8.4.0"
  sha256 "1e18ec0e9e473cc50a53dfe1c2f88d11ef7e81cc96581a2a2a2b49d47893466b"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 58
    sha256 cellar: :any,                 arm64_sonoma:   "2cbe3112606de78aff9f208512e5dc6f81aa387b0bf171ed3e0d0bb3236055a4"
    sha256 cellar: :any,                 arm64_ventura:  "9ec53b5fb7dfbf686cb241898017ea1a4dc9164253fd7e1c029e000f67480776"
    sha256 cellar: :any,                 arm64_monterey: "6ae58b312790c6eb7ce67b74c2a256ca10888d2c4b2ea26f7be0704f5c355e78"
    sha256 cellar: :any,                 ventura:        "ccb4da42af0ea4556996b06cc7253790d2090a8bef4333400ed62b252f9a0ab2"
    sha256 cellar: :any,                 monterey:       "b6ddd447acd9a093071cc7b64d9bda1605914578b546412931a7ecd01319bd09"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6d1d4d00b9e27b4d391534b0d9085bc3c5704d1cd21ed7976c16bec6d745ba6"
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
