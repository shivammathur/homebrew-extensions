# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.4.tgz"
  sha256 "80ba7dbabb7f7a275907507186ecb27b559e64082a22ba1ad39cdd129d383ce5"
  revision 1
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_monterey: "6f27e4ef02ed7548492a0f6d1d316a98a139b977ecde07e86db8e8117eb0105f"
    sha256                               arm64_big_sur:  "7f02d23ce5030e96d843ff7eebb5fc33142fbfd5b0064cc299576b79e19b5b3d"
    sha256                               ventura:        "5234248ea759f7be73ce1c07b4bf58276fff9cc96fbe6f04cf50fefccee80143"
    sha256                               monterey:       "f583aae0f12b2e6ea7f14215248142fd86a34add84d0cf60fdcf9eb933710abb"
    sha256                               big_sur:        "fbf8276508cf54acf18902b953a0c239edadc4dbdd77c09a879e49369b8c0208"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6fa9336ad7f64691002f853ac2b9dc0d99e0473920f654a712ca2568217a1e32"
  end

  depends_on "cmake" => :build
  depends_on "openssl@3"
  depends_on "zlib"

  on_linux do
    depends_on "gcc" # C++17
  end

  fails_with gcc: "7"

  def install
    ENV["OPENSSL_ROOT_DIR"] = "#{Formula["openssl@3"]}.opt_prefix"
    Dir.chdir "couchbase-#{version}"
    inreplace "src/wrapper/common.hxx", "zend_bool", "bool"
    safe_phpize
    inreplace "configure",
      "EXTENSION_DIR=`$PHP_CONFIG --extension-dir 2>/dev/null`",
      "EXTENSION_DIR=#{prefix}"
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
