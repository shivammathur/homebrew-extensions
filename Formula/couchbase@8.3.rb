# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.3.tgz"
  sha256 "bfca3512e59dffc9f981cba0294387a50a83c1f7e446de92ae44f8d1d421194a"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_monterey: "81c740fd9ce9d91bc5155d8ecfd19e26224c76afc95b430b7b02133c1cb8fcad"
    sha256                               arm64_big_sur:  "a4fa6062a7c06f5b23530210b86266202397c7c968cbdb01dbd6dedd7517bf6c"
    sha256                               ventura:        "fa36891167a14c63d6ffc183842284393162372773b9b62e6bc04d5898f2fa8a"
    sha256                               monterey:       "463e1c30c403f023a5b2718dd85991d8d2ba9e0d0c19cec79ee532bd3847eed6"
    sha256                               big_sur:        "de6a12bda114db733b2b90bae2753fffdf44c13f98d1a90704bc3c0870f748f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9cc66b825a8e06bde001abff85657d7606bf1b28c4626273911838876e765741"
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
