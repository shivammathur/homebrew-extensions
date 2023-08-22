# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT74 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.5.tgz"
  sha256 "e1335d70e10687e969ec73b546995d1fe8937ebe511d97c71bbaf2d66056d9f5"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "36ae0fe0f970cb2a6d42b64c612ac7e16bc23c144cf5878b5f45fe9526c24a83"
    sha256 arm64_big_sur:  "fee59ed93905e8d5dc17cb0eb35295d6484c977e8a6119a003910b53427ac19c"
    sha256 ventura:        "fb817259d4cdbb1663cc37a20df789c819d0a08340290d891f40ac8f6b6d2030"
    sha256 monterey:       "6b4c33936d1e6f95c8de7e737cac74ef013e5976843403e50a026eeec8defec8"
    sha256 big_sur:        "09e1604b9f14471c4268c27f0a2b5a3d0cfdfd20271b94afd20b8eb9c1b931de"
    sha256 x86_64_linux:   "f54a63c34b672ef1f5ebee15e57600453a032730fbd5ca88f7e7a9f314ea4dfe"
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
