# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/e1cf66b6cbc1ef5b12daa4c3a052810c8a93f5fb.tar.gz?commit=e1cf66b6cbc1ef5b12daa4c3a052810c8a93f5fb"
  version "8.5.0"
  sha256 "b0227a69f1b10abf84f8e64f2a5556b8cdef072afd4619c74a464c0ffcdb4cfe"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 37
    sha256 cellar: :any,                 arm64_sequoia: "0fbbfd8d0bfec3ffe2f3adfab9d1c75cade94bebfceb81278952dbc696cafcc6"
    sha256 cellar: :any,                 arm64_sonoma:  "0ed4af0ae5874aa647cfb74fb7a7379fc7e5b1445806891d2fdd1077b8d94bf4"
    sha256 cellar: :any,                 arm64_ventura: "f78fbe6e59eca609e534fdf67cdd5c8001c687a5cec99785c2c1286d5f721802"
    sha256 cellar: :any,                 ventura:       "726884bff9775d668b2299d9723a77a1509fa99b41b38e7e63df9503382c19fb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "543aa2fa1b4617387a0fc5c02fea7f852bf0ba1a49c545918f92c4373c209748"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c69b55ed652b3218c1fbeeea782876faead27a6e84326d241c0f4e6f2f34821"
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
