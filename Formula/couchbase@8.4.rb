# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT84 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.4.0.tgz"
  sha256 "328d57e1054a3f073d5ed2c29507871c0fcc5e0c9398e7f1d8227833c054e689"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "034a8e6564569409611f95386147e20bb6f5533c70081aa82ecbae35eca4be5d"
    sha256 cellar: :any,                 arm64_sequoia: "893eed672f5a6d32cb79cf62e440498bb166f198dcf2e9b8cf88258ec253b89b"
    sha256 cellar: :any,                 arm64_sonoma:  "cb6a2d8926ce24094962d3154caf8801343b12355809bc53e521ec4023ea1f01"
    sha256 cellar: :any,                 sonoma:        "e45c1210424eee9acd3332dfe37baa9126b4121bc3c051d0fb0a2e139e984030"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "14e70985276f8f7c6b58e1392d3c2b73e89bd12534b83e28e86b581e338de0f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c801c7b123643737486061d1e139bacdfa875342af3d55e5c7fb3af17062f6fa"
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
     '-DCMAKE_C_COMPILER="$(CC)"',
     '-DCMAKE_C_COMPILER="$(CC)" -DCMAKE_POLICY_VERSION_MINIMUM=3.5'
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
