# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT80 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.4.tgz"
  sha256 "80ba7dbabb7f7a275907507186ecb27b559e64082a22ba1ad39cdd129d383ce5"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_monterey: "1c5f9d5f2d86918d4df564cf6f55ab9f01dd599ac4524b624fc0599ef76f4d63"
    sha256                               arm64_big_sur:  "f58a5d6b9f3bb5dfe8d12a177200dd7b76be9cbc07b3e502e8100af2af76b945"
    sha256                               ventura:        "2c5c945aa618e07fe70590e6c3b5a305fffb34602953f80c920027e22ad0bf06"
    sha256                               monterey:       "53a0c7faa2ef1d95fd4c77d8026b2b97bb6127b3330c42bc1e76f9906c32a202"
    sha256                               big_sur:        "2d993462f409dd97aa21c7e6112acae1536de0edf2e01eb5231986f58ad569b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1a31cd68f8a944251d1038317201ca3ce294a811f01c3bf751e113122051d6f1"
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
