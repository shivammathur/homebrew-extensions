# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "b2409b3bc60cbe9eddb5978860c4ef9b00944d79575ccd6a6c4c0483a76f2c85"
    sha256 cellar: :any, arm64_tahoe:       "28d66bb6d827ef0ae86dea531a94a47fd0411c54c6f52cbf851aa3f6b957eb7f"
    sha256 cellar: :any, arm64_sequoia:     "2d7df8e0e987cae050c17cc0d5828877d81ecb92646503140b730eba3aaffaf0"
    sha256 cellar: :any, arm64_linux:       "f867679a64d47062c3847e6e84882f25a62a0c9cc1155cff56eccf9bc29eac6d"
    sha256 cellar: :any, x86_64_linux:      "9ee16432d70bb14d9fbf12608558599291cddbda035b23a66a7fbf663b5c2755"
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
