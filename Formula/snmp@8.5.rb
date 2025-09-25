# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6e1b1900f00f2529c1330c03c5cb87e6f3cfa905.tar.gz?commit=6e1b1900f00f2529c1330c03c5cb87e6f3cfa905"
  version "8.5.0"
  sha256 "5a6b164f91b55d8fae998383b790c20e73b9a72d6dfdaec829150b28a9fcb788"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 45
    sha256 cellar: :any,                 arm64_tahoe:   "3b73671458d55342539fcb605dbd2741f847a5e33a7e2a37c8021822cc3f11ed"
    sha256 cellar: :any,                 arm64_sequoia: "47d25db3a26c5fe6774d4aaf482b950638f489da0cd5ebb6cb0cd6d362c4f1a7"
    sha256 cellar: :any,                 arm64_sonoma:  "782e7fe5a1fe0a1c2826092356d583f45ddbee1b88b3f08b9ed3f2760eb4ec07"
    sha256 cellar: :any,                 sonoma:        "47353acf77e27efd88fdc5ccbb2868b5a456f21b36fc2c6dc710032f82f3b3e6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ccc9ca4a3a1edab02d863934ca04405bd10ccd41185f5028f7339c2d3b6aea18"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8d96a7f5df58fb2ecf09db6901de533acdc52907d3b7de5981e076a07ccf1012"
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
