# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "2fd7a07df884fbec0f52b6923d38fc82f2f464f8734cb39d11e46e5928d2f579"
    sha256 cellar: :any, arm64_tahoe:       "444cf88e6c176b442085431255d6257c68c99287f22b82ca9b9cdc0900ae3c06"
    sha256 cellar: :any, arm64_sequoia:     "1db703b7053f8598e69733f2e41aa518236683eef65a534a4b4882ccc829144a"
    sha256 cellar: :any, arm64_linux:       "fed36a87358ab9ac7ea6d398220161d6f46fde2535d18c7649e041062a4f5780"
    sha256 cellar: :any, x86_64_linux:      "5d4a5e7df2f8947d32fed3557e0441f39e226e9408c50e387adb15f4afb8a3f3"
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
