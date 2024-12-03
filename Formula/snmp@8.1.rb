# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.31.tar.xz"
  sha256 "c4f244d46ba51c72f7d13d4f66ce6a9e9a8d6b669c51be35e01765ba58e7afca"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "5dac2305c8fc4c4cfc72890d081fcb2a6d54c7f65c2a0e3582cd144dda2b1485"
    sha256 cellar: :any,                 arm64_sonoma:  "6a8cb6cd1fdca45356adff869b9c4392dc18b9f6b63fd77c5e640944cf73e1dc"
    sha256 cellar: :any,                 arm64_ventura: "0b1eb4ef52c257c87bb58968576f1d84f0713088e87878b800a8a5705c51a503"
    sha256 cellar: :any,                 ventura:       "c2e650e5d5cc41305fcc960ffca0a9c26383c827b1cecf83996d23b383fca8dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef29cc30ac5833e8bcbeb081b7dad48f6fb15248d6356bad95f409886271aa49"
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
