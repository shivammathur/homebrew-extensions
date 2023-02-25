# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.1.tgz"
  sha256 "861ba1c7c6b3d0247b26772a0ae951780f298f3cf4ff4edc9a8c3cb3998a4599"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "5b471dcf7e74018431526ec19315609e81cecd6d18715f8c08acd60363f61c89"
    sha256 cellar: :any,                 arm64_big_sur:  "8dceb99cd0c8f924c0cea0230f6ea5d99dcb54511c350b743c2d6dbbe231a1cd"
    sha256 cellar: :any,                 monterey:       "61037a62f22fef350cf5f19e420e9fe3a56fe8c99ee56ca9632e166f3988dc77"
    sha256 cellar: :any,                 big_sur:        "a21742e932734f54c77286c3e3c6ffac1adf38c3a40d08c7d80d431775ff5060"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5f7e2a250f0daaef077fb6548fbaaa46f7f775fa50500fe884fed6269cbba643"
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
