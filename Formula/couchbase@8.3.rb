# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.1.tgz"
  sha256 "89c3a72ceb4afb1399fc5320129a491fad5dc58b4a482fcfb526e6267e729f88"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "3f4860af220ecc5d99ab15e139a184ef4abcac708976cf088a43ace1c332d2bf"
    sha256 cellar: :any,                 arm64_ventura:  "16d154b18f3ce303233e326c8ad7ee0bba86696e089e9e1796195a54b7da887b"
    sha256 cellar: :any,                 arm64_monterey: "6c1d86222bac5bc9fff5c03627d9ffdc64f0b8b9a5322fafcf460fdb617286a8"
    sha256 cellar: :any,                 ventura:        "6ff167ceb12ceabcaf8d7680fbca575ddd9884e267dd0ace6801c0ea98dd8fb5"
    sha256 cellar: :any,                 monterey:       "49b69a64459261ed718ea89f782847127d2a74c5f2cadf6ea68cc45ba2d9b54f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "96f9377993cde8158d9b7ccc653b0f6c4bac4dd40865ed8c0b58502a2f83a31a"
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
