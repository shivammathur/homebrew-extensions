# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.6.0.tgz"
  sha256 "75c692523b31201e4c6ebb753229f7b5b465eb87e42e2573e573b11225d9e2e4"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "cb96acf5ba373f8e6d221824f5d5ee339f39ff0977131d8e88b0372e2b5fd547"
    sha256 cellar: :any, arm64_tahoe:       "4f65b46f3bcd7da444f6f237fc522b779e1c48be511afe5d3dfe09a6cb2698fe"
    sha256 cellar: :any, arm64_sequoia:     "54dbf8b43766847d4d140f7abc265672763dfe99a9dfba7f8319aa0a2ad92d8f"
    sha256 cellar: :any, arm64_linux:       "8038581fa51b373d0d350b367590924b21b78d68a39bc38e45a35c88f0c7cbf9"
    sha256 cellar: :any, x86_64_linux:      "2051869172763b75b3c79682b6f1d45dac9c795bfd50bc32a728a0bad6d09476"
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
