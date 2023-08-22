# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT80 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.5.tgz"
  sha256 "e1335d70e10687e969ec73b546995d1fe8937ebe511d97c71bbaf2d66056d9f5"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "cdd4f02b1047d768347eb6d3f2b14288e7b0824dc0553d9ce2b45487d8b45b06"
    sha256 arm64_big_sur:  "570680204a06b6f418912bbbbd2b9524d5d20293e28966c6224c5bd7bbc2dc7b"
    sha256 ventura:        "9529c0d3b21f0abe880f8122728411b505a1bba3dbedf3855e0c0a585b2fa338"
    sha256 monterey:       "e38be029d31486e076bd6a65459a1cb7f58aa1a9acc02fc0967022dc8d863019"
    sha256 big_sur:        "da8061fa4fbe2307d1f5b3e394e61229c1a1553345bf16fc416d2f5bf1d44620"
    sha256 x86_64_linux:   "7b37facf8f75291b8093a6ab67c6d458cc15438df7f06158142f91b6e8d770ed"
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
