# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.6.tgz"
  sha256 "43da457eceb494a8fee95cbb7ff9383efe66899f525cf530760507257080597f"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_ventura:  "d4e0594912e87f4ce738fb1ab18b6ab531395dd2c28c82ccd0642cde2f5cbdc4"
    sha256 arm64_monterey: "40e41b219a47ed1d6fa058ac73bfaa09506e385c422da97f4b10a6bedf392c68"
    sha256 arm64_big_sur:  "81c10adf92b5a15404285c6a831bde6d7b877bc703c1e1f5cf40fa38ff4b40f8"
    sha256 ventura:        "33b0dbef13085119d23ae20d13da6a4fed38c771e6b26646001df68e24ee263f"
    sha256 monterey:       "c93bcdc04c088d4e22101a3c456692c3cd8187a24f3f2e9d5967dfa61ba9c9f1"
    sha256 big_sur:        "534465e6e30f170127a8577dd2d001c1079307d906fc390fdd5796e5a0d78951"
    sha256 x86_64_linux:   "05d8af4632170f7c37a4d2bfafe06cdb23bc164a3bff08ca807a03491bceaa40"
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
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    inreplace "configure",
      "EXTENSION_DIR=`$PHP_CONFIG --extension-dir 2>/dev/null`",
      "EXTENSION_DIR=#{prefix}"
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
