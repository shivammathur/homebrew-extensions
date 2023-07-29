# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.4.tgz"
  sha256 "80ba7dbabb7f7a275907507186ecb27b559e64082a22ba1ad39cdd129d383ce5"
  revision 1
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_monterey: "9e492de3b93af5b5d59dced57337d5de9d1faff6fd1572465d3852ef06852a22"
    sha256                               arm64_big_sur:  "5d4cda9efd9c5e9af78baed7ce4a66228638bfb7ad7b746251a2f84992239df1"
    sha256                               ventura:        "e47587cdd32b6224a5a7c9e1f9b2e730369ce99f0f4f68d996ba8cf085d85656"
    sha256                               monterey:       "c05446e3ca3faa169535aa79dab2365704040929a0373fad011bd0145fff237f"
    sha256                               big_sur:        "a1b3da8acbde3bb10f63f1ad4079f4cf45cde5c913207ff65a55e5892832e7fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "945c5aa10698a57053fb640ff73dfc4c15feb09cbbb0816cf56513bb5a9858a0"
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
