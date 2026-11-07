# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "e410341cea17eab0e520cfb90aeedcabb7dc9b7659d8c625c6d1c2a1587cd30c"
    sha256 cellar: :any, arm64_tahoe:       "e177c8baf675efbca7743f73b78f9e2f03486fc48c24e8a82c45bddd4b801eaf"
    sha256 cellar: :any, arm64_sequoia:     "cd770dfffe7da7a384c5f2c8b23900bcb2546e08333c539470bff20ee97c2435"
    sha256 cellar: :any, arm64_linux:       "5cb7f653dd9877c5cdd811260517d6a8c5e31575c0c2611458b36db39f719dec"
    sha256 cellar: :any, x86_64_linux:      "7b4778a25716164f6b23e5a38fa0826315745368863debde5fe9cf9ffda29402"
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
