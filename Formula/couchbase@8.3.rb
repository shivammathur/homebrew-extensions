# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.2.tgz"
  sha256 "c5d3109365a47a785ad21713a27cbb3da7205da506bc7bf255ea04fc14d835e2"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_monterey: "1aa982a21191371429c66c3fe12a1589d14cbbe24fa9a64715c49d89a6939d1b"
    sha256                               arm64_big_sur:  "c90416064368b0317e8e8efe257fb2932e829df2574bf00da5d85966ad1c0ffd"
    sha256                               monterey:       "67921b59e9df5ae342ef80ef9c1f78318d7c68030c4b76869f7d230f568feb3d"
    sha256                               big_sur:        "0fb6a522dd9d7a71b56b6a0cc8a1d4652c09e58f2125486409b92bedd1c758ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "51c0fb3e08b72c36a180ce9aeafbbda699e209b014cdcd0c658c795c442fee7e"
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
    inreplace "src/wrapper/common.hxx", "zend_bool", "bool"
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
