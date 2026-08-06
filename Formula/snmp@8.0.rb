# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/1bb9988fd6c151c783653e3a2257c1a0897e6633.tar.gz"
  sha256 "1969f16cab5dbf112b0f1115279d061f29f63d8910cc56c497cff59c853f9f6c"
  version "8.0.30"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_tahoe:   "2bcf0ee513bcd98311aa6dd658026d80027ed54e489d9e3921d38771917ef2ed"
    sha256 cellar: :any, arm64_sequoia: "bc13cd0aa61c8521bdaa0914c9c5fc3e7771c588149a3310782ab645a05d2b71"
    sha256 cellar: :any, arm64_sonoma:  "661883d655c2342bcb0c36f11408b43b1aee751439ed1772b6ce3345ab8da6c7"
    sha256 cellar: :any, sonoma:        "b12d783ffac745573cfd471eb588edd7a71ec3a28f9597682083ed99bceed30c"
    sha256 cellar: :any, arm64_linux:   "917437418453e3150ab6c1879f77eeebbee1e3d35badacb218f7d812e7729e38"
    sha256 cellar: :any, x86_64_linux:  "2f841b7a38ac27b8eb1c2149e7651c9b8fe978cd16fd8ad7af0e54242f8ce3ab"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
