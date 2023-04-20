# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.3.tgz"
  sha256 "bfca3512e59dffc9f981cba0294387a50a83c1f7e446de92ae44f8d1d421194a"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_monterey: "57176dc9a0d26b283e7fd7739d5004145bcc6aa9bdd42afcce208d1a7518adab"
    sha256                               arm64_big_sur:  "f57c275f882ff2a982bf61758b48fb4f37ab42ac1ac8721ee35beb247f4a8a3d"
    sha256                               monterey:       "1d481f9c7ff3590ec635f95bb8dc895a37796322ef4736e613ad5ca521435605"
    sha256                               big_sur:        "74fa521a68c4ef65a6a9e88893584752ff85bb1bd6553a7fa8f00478ef0d663a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "335e56640563b71f0a7d3a1f4ddc5b4949a73235ff10f0b4871e42c013f6b714"
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
