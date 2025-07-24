# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/d292968f7c656255f8362c619e8ccb804d7b802a.tar.gz?commit=d292968f7c656255f8362c619e8ccb804d7b802a"
  version "8.5.0"
  sha256 "dbb747251cfc82a4ae7d58f2aa1071e5b589061ad9743dbc55e67b5208f8a6ca"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 36
    sha256 cellar: :any,                 arm64_sequoia: "b016f3eaf8792da9a9a1906ccdc3b0dbd98a175f8c1e1b67798f9f48e0be6660"
    sha256 cellar: :any,                 arm64_sonoma:  "31c708a73fa86659a52da342890e433ec7f51309fe5dc91d272451ff8e288c31"
    sha256 cellar: :any,                 arm64_ventura: "70e818deedbe9fc8e4d1680970ad81423c0299eb35a777354c4f0af38bb00cef"
    sha256 cellar: :any,                 ventura:       "f3b1b5839fe4f9423b0c6258d98c5d218c189c8c269e415ecb4a8709bd54e870"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c5dd1fdfef7fb1fb567e178fae87a1bc05f7f82a0c7df7c514eea32c13fda522"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d91a412a6b935c0124ade9bcd15bde1243a281feefadeddd87d2274aaf0a74e9"
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
