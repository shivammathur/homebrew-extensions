# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT87 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.5.0.tgz"
  sha256 "f31385068fc197516012eed85baf732eb58186a95a1d6da09ca03859f0b71747"
  revision 1
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "2d9f504c0942f6868c9048b1e10c4e7e9fee576f2e8d7fdcc5972a79cea084a0"
    sha256 cellar: :any, arm64_tahoe:       "829ba0806b15f85396fa0e92cb3b2a6f9bd73889b77ab017d778246b79958187"
    sha256 cellar: :any, arm64_sequoia:     "3810a85e8e627638446dfc7bf53e5f05f964f2190a514447a0d60054b5ace1e9"
    sha256 cellar: :any, arm64_linux:       "3e283e1635e073584073bbb3b326df3576120b2758a6db37605fed6511b42064"
    sha256 cellar: :any, x86_64_linux:      "79d475dac4355fced9f4ceb96aab3be85e8e5a352490c9ea91cd97e9a39e0b6f"
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
