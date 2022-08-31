# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.0.0.tgz"
  sha256 "caa67e972a8e0f50b920088434eea14671902f253fb5bfb854b7e8d3898bcd26"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_monterey: "fbb5afcf66ed7c468131c793bfc1f9b36424101ff0688564b2c4454f78a09ab1"
    sha256 cellar: :any, arm64_big_sur:  "a6858e6b2e7694effd89e2c1ca833f439edfda364b0ac343a4950469f617de6a"
    sha256 cellar: :any, monterey:       "c4748a903caf6bb2cf5b438186ac48b7095925d806418dd35247dd91dd91043b"
    sha256 cellar: :any, big_sur:        "4958f73c73dc9c2d8041cc946a4cd8559e42a07e8663037303332f5fef6c6a90"
    sha256 cellar: :any, catalina:       "430e44a56b8c5e118d23de3e5466d7ac56ce381ba0e2996fd84698bac2cd9719"
    sha256               x86_64_linux:   "0bbad4d4e9ff148bb91da6686965944d5e9f1b883898146c21465f03a4f3c9a8"
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
