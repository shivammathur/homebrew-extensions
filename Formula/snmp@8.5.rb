# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/89dc8d79a76128f961e95b91bc5bc7a8b33a99cd.tar.gz?commit=89dc8d79a76128f961e95b91bc5bc7a8b33a99cd"
  version "8.5.0"
  sha256 "954a45f4647b48246b2ee2ee7fa22d2c645315b329fe6040fec8550c27dfcf5f"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 24
    sha256 cellar: :any,                 arm64_sequoia: "f7ffc0d2c0f0c9af8f49684e2fb92607681bb6757ff802246d5fa4b715a17d6b"
    sha256 cellar: :any,                 arm64_sonoma:  "d5a1e9cfd058b0aa7affffae87bb385a9c76125502de5098b6113ec98d958128"
    sha256 cellar: :any,                 arm64_ventura: "9a322eaf1b81d86c3a7f7883eedb7f65494133ae534ca76393de2d41c755c278"
    sha256 cellar: :any,                 ventura:       "584c28dba88a4f2356f30c18d4f67e6ccfb112422255430a31187ee5931025d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7976a96a0cda0811a71660db71b3465170a93fcfd8eb38abde7bfcdf4c95a19b"
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
