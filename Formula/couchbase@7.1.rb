# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT71 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/php-couchbase"
  url "https://pecl.php.net/get/couchbase-2.6.2.tgz"
  sha256 "4f4c1a84edd05891925d7990e8425c00c064f8012ef711a1a7e222df9ad14252"
  head "https://github.com/couchbase/php-couchbase.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "805fffdf46a25e305a261d9dad8188a55d4f24496e7a51c6ba6957632764ec19"
    sha256 cellar: :any,                 arm64_sonoma:   "d31984de6c56222b33ebc3763344ad5180332a853565c5e0d9a6593e8c7accb7"
    sha256 cellar: :any,                 arm64_ventura:  "b59e1e79740f78d317a82d81af73ee10bd5e79795b828d2bf9f9c054df312c03"
    sha256 cellar: :any,                 arm64_monterey: "c02a744e306752c313bcfcd32ab9dbd2e8c4394b218fc665423cddb2efc355f6"
    sha256 cellar: :any,                 ventura:        "d76edeceeb78577f4faae00f2f9a343555fffcbac9c2a0ee6b314591f0e2b2c1"
    sha256 cellar: :any,                 monterey:       "55c3778614ba18930b386bc41ca9dcf997df103abe13e81be6454dbbe0e95dff"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "19a28701502b9b8ced5c832d85222ceaa65a7ded497dbf0324bbbba67261b772"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "036ea925aba50ced6a30b1f69c527d9da1d627899b00fa9ce896873e19c119f7"
  end

  depends_on "shivammathur/extensions/libcouchbase@2"
  depends_on "zlib"

  def install
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-couchbase=#{Formula["libcouchbase@2"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
