# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.3.tgz"
  sha256 "bfca3512e59dffc9f981cba0294387a50a83c1f7e446de92ae44f8d1d421194a"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_monterey: "00d7d0f00685116be8cdacbbb5fab5d24115e490805e5d85b2fc31ea46d215d9"
    sha256                               arm64_big_sur:  "d7408b161989fe70d3f92655397a8de108ec910f7c1494f0c3a28fe79006c3cc"
    sha256                               monterey:       "7614faf2b2ea3c8a0649fba26ff5438f2a67e23bbfce1570038fba976afd5c55"
    sha256                               big_sur:        "32d22849be0a0e2a16be4f142d8c446f4e62c9397201a5b92e0eaec1495dcd59"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c5c7010613b573c290ba08970d2e4478d5f1487f185bdd8eabfbdae4bfc0a88c"
  end

  depends_on "cmake" => :build
  depends_on "openssl@1.1"
  depends_on "zlib"

  on_linux do
    depends_on "gcc" # C++17
  end

  fails_with gcc: "7"

  def install
    ENV["OPENSSL_ROOT_DIR"] = "#{Formula["openssl@1.1"]}.opt_prefix"
    Dir.chdir "couchbase-#{version}"
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
