# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT84 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.5.tgz"
  sha256 "e1335d70e10687e969ec73b546995d1fe8937ebe511d97c71bbaf2d66056d9f5"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_ventura:  "43c55c7544bf172eef92172459a4759393fcee4518e1c0449a09d46584324878"
    sha256 arm64_monterey: "8344e887280a975f36fc84e24523420d64bb38d664726fa459700f4320645148"
    sha256 arm64_big_sur:  "140a84ea359454521a1f2571a2345e2858d6f066ea8e4c4e2a7fa8334eb35927"
    sha256 ventura:        "03072eaf3ef5081b3735a353ad9f4530681bd7434d210723cf8c111ab072f138"
    sha256 monterey:       "a42932dd2cb51bef9479d46149af6b335160cb4098a987b9fb379fc2476cc405"
    sha256 big_sur:        "6c60079258ce330aaaff4750e2d6d2d11037136dafab3e081003c044a8b69f56"
    sha256 x86_64_linux:   "3617e4559666de086f81b4d58d895229f492c74571ddfc6ae63b95911592a34e"
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
