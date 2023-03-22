# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.2.tgz"
  sha256 "c5d3109365a47a785ad21713a27cbb3da7205da506bc7bf255ea04fc14d835e2"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "1ec16d947dcd4fe99de8a23a5cf71e208c23a6fc5b30921b85b870f89c7922a3"
    sha256 cellar: :any,                 arm64_big_sur:  "3d430290d3b92e43807093465868e00938adc341be08c8242875cdb532eb9440"
    sha256 cellar: :any,                 monterey:       "ae322fb73221065f4aa32dd3fdf94bc3ffbdf65e61bf9bacd92aad213d79c197"
    sha256 cellar: :any,                 big_sur:        "a3d1e0b77677ccaed93713fa4e7bc5bf83deff3ec4c9fa503070309f907d0251"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "634c90d31268ac6ec98d9151a6b620ea0bcd45431d0a9ac4684d842002cb8a1c"
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
