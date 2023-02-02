# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.0.tgz"
  sha256 "3f027727615848da928df347bf1cbe7a867f8a362b56eefe8b2457795f8b4492"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "e12a53c2b12ad92e582fdb60181f5e0244c46e211d4d78b3752f64800993474d"
    sha256 cellar: :any,                 arm64_big_sur:  "f813241f1509aef950f2dd28a789046baeed259b9ca7f8d52eeb99e5935e66a4"
    sha256 cellar: :any,                 monterey:       "bd89fb1b955de46828358cdb0043fc083648bf8f589522a42682faa3b93ca29e"
    sha256 cellar: :any,                 big_sur:        "771862b046e8a7def8ec984974a99ad5701955974c0de0bdcd7fc24c4ed62227"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8a9b46f48c560a18c91da8b7803f17d32fc2acd667683de05180c06aa4963867"
  end

  depends_on "cmake" => :build
  depends_on "openssl@1.1"
  depends_on "zlib"

  on_linux do
    depends_on "gcc" # C++17
  end

  fails_with gcc: "7"

  def install
    ENV["OPENSSL_ROOT_DIR"] = "#{Formula["openssl@1.1"]}.opt_prefix"
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
