# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT85 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.5.tgz"
  sha256 "5b5d830ce2eadb551a251070082b910ccaedd9fab9dc5c554a0bd98b7e50ca5f"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "a54615c459a80c20123bb7263e338154a66257d0c93a0c1b753f05a86aeeeb3c"
    sha256 cellar: :any,                 arm64_sonoma:  "26b5c9ba7e4dea3bb3ea646314d2dfbc3a41284fb5fbd7495413037f88a95a2f"
    sha256 cellar: :any,                 arm64_ventura: "23cb23407d328ec0b2b15600117e2d18968827a32a7f92ab66ea1df5f5eb3cfd"
    sha256 cellar: :any,                 ventura:       "6d49132e4c8ca288acd09b90337d0c621ef3c0fe3eaac5c2380c826f1ff755ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ecffa64d01e37f4078acdd033fb696ebe9e516f8be3116ec850ad58f2e3c198b"
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
    ENV["CURL_SSL_BACKEND"] = "SecureTransport"
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    inreplace "configure",
      "EXTENSION_DIR=$($PHP_CONFIG --extension-dir 2>/dev/null)",
      "EXTENSION_DIR=#{prefix}"
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
