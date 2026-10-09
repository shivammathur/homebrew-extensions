# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT85 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.5.0.tgz"
  sha256 "f31385068fc197516012eed85baf732eb58186a95a1d6da09ca03859f0b71747"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "74f974c64c0ab253eee17819c936571324d106828b4a79aedaca82e3d582689a"
    sha256 cellar: :any, arm64_tahoe:       "98ffa3b9061285f8204844c5e83efb1fbe7911020764b38d23be1c01aec416c3"
    sha256 cellar: :any, arm64_sequoia:     "093b0d999fd072840bf378b053a2dd26d131c3ae95f5524ad0d03465b31fc716"
    sha256 cellar: :any, arm64_linux:       "1e2fc30036c0ce232d74ef5f4890a1c4ec41e1c4feb824e602fdf807b543072c"
    sha256 cellar: :any, x86_64_linux:      "6f5f18309493e10f1e18d560b74dbfc22e5d5e20896a0158aa48dde0320e2dfc"
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
