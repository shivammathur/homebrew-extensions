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
    sha256                               arm64_monterey: "3a81347f1e4aaefaba223c1723ad73e337ecafdb7e1f3a5a5e5cfeceece41bbd"
    sha256                               arm64_big_sur:  "15134bc50e712afe147b21a5a63581d1654e49f4cf8e3deea3f65c87f58090d9"
    sha256                               monterey:       "35d489a1740197a1bf83759975714d12b5b043c6d4545c2ba0eb76afb6e18d84"
    sha256                               big_sur:        "22cfd2f775e9a98be5a2ba56cb2142dd76c6e1f84c53f08b0f666a2f8c9c9408"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6fced522498e682d0c45e3790878df677366e2eb8f64fac018d7dc26d7ee9571"
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
