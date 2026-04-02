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

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "7d7d4c9a89e6e57e7bbb6b788bb64d8c216c0c2f0ed936670f0fe964757b7350"
    sha256 cellar: :any,                 arm64_sequoia: "4ef1cb0d3c997bd77542d6fa72da82ccdb5021170cc110e9c2a20dca6821eaea"
    sha256 cellar: :any,                 arm64_sonoma:  "3f15bb0a5d2840551804ee99b480d9b26c3d108555e198a85afdbc82fe3be4f1"
    sha256 cellar: :any,                 sonoma:        "b95c93780c899950f1f755f5b09e4bc077ca9246caafd2be1dec9e06eb530068"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f67d797eb20ba2c792ce1d994572bf6365ca623bdbd58c6ec19de7aaaa649054"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3379b8ede5fb294c3e22dd20ead0c09f21c996d594d512089d8cae7b7936c110"
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
    inreplace "Makefile.frag",
      '-DCMAKE_C_COMPILER="$(CC_PATH)"',
      '-DCMAKE_C_COMPILER="$(CC_PATH)" -DCMAKE_POLICY_VERSION_MINIMUM=3.5'
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
