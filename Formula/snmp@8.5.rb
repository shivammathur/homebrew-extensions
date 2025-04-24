# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7ac1b0c917c59c29b087ffb333a8b6b3fd8bf9a5.tar.gz?commit=7ac1b0c917c59c29b087ffb333a8b6b3fd8bf9a5"
  version "8.5.0"
  sha256 "342ed2b765d2c9c6d3385965a0db91bfc5e3906982e0bcaa48bba991cdce8af7"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 21
    sha256 cellar: :any,                 arm64_sequoia: "58a1a74ab0e193f00105bb6979d0d255f530a2ebc56b4803a623d0453fbc6001"
    sha256 cellar: :any,                 arm64_sonoma:  "e1670e497843b68f3781151af916ea1775220ace1e062577c917e8b9e7590f17"
    sha256 cellar: :any,                 arm64_ventura: "edf87f1b1940c1186e5a63634f4ac79db897c74d6d353bf59511c8c97a717452"
    sha256 cellar: :any,                 ventura:       "ecd67ca6da85ecba50ba6389973255fb4adc75a6f08dcd35b662fbd450af71b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d2966d895af23efe1c657632b9292ac57ef82461d90ecc71d34b4ec045bfd40f"
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
