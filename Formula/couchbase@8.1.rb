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
    rebuild 1
    sha256 cellar: :any, arm64_monterey: "207af3d431adf8b0b88a77820457de01cd0cb468b3ddadaade9a66d5fb09e29e"
    sha256 cellar: :any, arm64_big_sur:  "af6ac959ddb837d6e655b04b3dc910dc5f798b5fcc3cc49a0fedf3c548db6547"
    sha256 cellar: :any, monterey:       "592a2130217d053a9563eabef71d9cad8f8f24ec4c70048134028b9e688d3df2"
    sha256 cellar: :any, big_sur:        "9b62737a38b0666fa87f1f7d0dda4a08c52e9976d224bbee7747036ff012b451"
    sha256 cellar: :any, catalina:       "38761a76b7dab22ef1b6246671955a9446b312ddd7e90bb5790e4d5d4965c812"
    sha256               x86_64_linux:   "e34ee6902908e55a8807a7c20d3bb8394e0a05620751ec111dc6f4d081b1e34c"
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
