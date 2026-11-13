# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT87 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.6.0.tgz"
  sha256 "75c692523b31201e4c6ebb753229f7b5b465eb87e42e2573e573b11225d9e2e4"
  revision 2
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "7043aebf1a5f3d20956c60d7aa14780bf740c37acc09d5b4363c7f40fa455f6a"
    sha256 cellar: :any, arm64_tahoe:       "5fd32449fd75600f6abd0a0105139a614f00675cb459144a4484ee540f164ac4"
    sha256 cellar: :any, arm64_sequoia:     "5a2c5b14670c4e157006dd4161ce9304c1f47dd1fb07e962be4d651f0a45cd31"
    sha256 cellar: :any, arm64_linux:       "7a245b6557b6aa1e5b19e994239cf7ad4fb3b32f0986e3ccd09ac57f1e49539d"
    sha256 cellar: :any, x86_64_linux:      "9192874163d1a1cb027e141992553fa054ca2b5b8eff9e140368eb1b65d546c7"
  end

  depends_on "cmake" => :build
  depends_on "openssl@4"
  depends_on "zlib"

  on_linux do
    depends_on "gcc" # C++17
  end

  fails_with gcc: "7"

  def install
    ENV["OPENSSL_ROOT_DIR"] = formula_opt_prefix("openssl@4").to_s
    ENV["CURL_SSL_BACKEND"] = "SecureTransport"
    Dir.chdir "couchbase-#{version}"
    inreplace "src/php_couchbase.cxx", "zend_parse_parameters_none_throw", "zend_parse_parameters_none"
    inreplace "src/wrapper/logger.cxx", "zend_atomic_bool_store_ex", "atomic_store"
    safe_phpize
    inreplace "configure",
              "EXTENSION_DIR=$($PHP_CONFIG --extension-dir 2>/dev/null)",
              "EXTENSION_DIR=#{prefix}"
    inreplace "Makefile.frag",
              '-DCMAKE_C_COMPILER="$(CC_PATH)"',
              '-DCMAKE_C_COMPILER="$(CC_PATH)" -DCMAKE_POLICY_VERSION_MINIMUM=3.5'
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
