# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT80 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.3.tgz"
  sha256 "bfca3512e59dffc9f981cba0294387a50a83c1f7e446de92ae44f8d1d421194a"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_monterey: "6cc9b75a1c4c54093e1fa8a5b9ec5a3b553f50dfe9708b6ecc28e8c3e57b5112"
    sha256                               arm64_big_sur:  "953d177466f75cedf18a3fa5ca211fc197ece35eba0a607ac56410f53fc88c37"
    sha256                               monterey:       "605c9b05b9c8742b5e432c3bf1008a3d2b3c5d2981fc1e2db34c5016cefdfc65"
    sha256                               big_sur:        "5f6664afa1680e0da21fc5437ff7ca91a9dec4e29eaaa306d12fc20a98093601"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4b8e09b98c6bbb3ca8e999bdd0017fa3f5d2bfd75aa426034af3c27d96458174"
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
