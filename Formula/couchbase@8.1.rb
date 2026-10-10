# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "553deb483c300d7a78bbefb94dc145692969f5c6bb50d9a6cf0073f39bfade56"
    sha256 cellar: :any, arm64_tahoe:       "48462cbea04bf27bd5e7b87014a2a5ac9491b443a247f6936db4cf5e47134224"
    sha256 cellar: :any, arm64_sequoia:     "dbbe0da08e6fb45d1f5d96707596a8db60d5b22c1e07b570f43c1a59b56208e3"
    sha256 cellar: :any, arm64_linux:       "c52aa7099a433794e393aaa109fd27d30c20fc8f24f6781fc96469eeefcdb288"
    sha256 cellar: :any, x86_64_linux:      "6bb6fac7b70444e4d72827040d76d08889475f468e327b0740f5e8865b5d2b48"
  end

  depends_on "cmake" => :build
  depends_on "openssl@4"
  depends_on "zlib"

  on_linux do
    depends_on "gcc" # C++17
  end

  fails_with gcc: "7"

  def install
    ENV["OPENSSL_ROOT_DIR"] = Utils::Path.formula_opt_prefix("openssl@4").to_s
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    inreplace "configure",
              "EXTENSION_DIR=`$PHP_CONFIG --extension-dir 2>/dev/null`",
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
