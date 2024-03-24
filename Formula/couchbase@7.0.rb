# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT70 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/php-couchbase"
  url "https://pecl.php.net/get/couchbase-2.6.2.tgz"
  sha256 "4f4c1a84edd05891925d7990e8425c00c064f8012ef711a1a7e222df9ad14252"
  head "https://github.com/couchbase/php-couchbase.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "84824f7b5cba52d924434ecc78193eb0981057a7c5042a2ab77ca96914a773c3"
    sha256 cellar: :any,                 arm64_monterey: "a4a57c77eb8bae0cb02583fae30b89e70a6b9706232ce7563cdbd888f6f1d5b4"
    sha256 cellar: :any,                 arm64_big_sur:  "a36dad803115a22acf11a978c877d0e0d88437d43857e9e023a690776ccb2f5f"
    sha256 cellar: :any,                 ventura:        "843a5abea95f95dcca038fde5446786c4d7cb3f0ecde93719a38c5f84b141884"
    sha256 cellar: :any,                 monterey:       "8c3716c2b62012dff2b791cbd8f8c9bbbd738a23a448461e546b1129c4c8f394"
    sha256 cellar: :any,                 big_sur:        "8f818525eec2357566318aa58dfe2153351848d680aa3b978d099e82ff46c6f6"
    sha256 cellar: :any,                 catalina:       "06dd84adf4870ee247796f9c6f148d7f5c398c38c48f0e7734b3d1c87989d67e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "84e7dbe1119a11592ba881d6fac7af1dc7d8c6fff21f2dbcf8009ddfdd547191"
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
