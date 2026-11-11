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
  revision 1
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "65a622ed87daa1a130037d5f62a866fd66f017e839c3612c5f169baf998b6796"
    sha256 cellar: :any, arm64_tahoe:       "139173c92c5e782e9fdd557b6225ff1dc305c39c13511906c331263d9ff578a8"
    sha256 cellar: :any, arm64_sequoia:     "1fcc9eb205e637bc552a8394a731ae78663816d818da9f3b8fa596642ccd66b7"
    sha256 cellar: :any, arm64_linux:       "b7c578d85bb45660785609d71fbb0997aabf5e7c4c1a2c205b5280e5748ac2dc"
    sha256 cellar: :any, x86_64_linux:      "6618bb1b96a5e4613fe055329c929c4a85fc60cc8df129406b8f7c2ab0b0b804"
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
