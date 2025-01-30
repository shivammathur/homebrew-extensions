# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT85 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.6.tgz"
  sha256 "728c466b9c5bf82639641e1fab84de7b690e5ded8ea0a4b1af5bf88919d49fac"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "60d0c024b5b350a72c7be73102a01fe2d4bf173010416d426859be77c1c2e8cd"
    sha256 cellar: :any,                 arm64_sonoma:  "3a141fd1f3c86d77305c7afdb21f8b6c204b4a04a3fab287ee45267c771153ea"
    sha256 cellar: :any,                 arm64_ventura: "b0f1d05e3dbaa358967e2e479a78eb5dc1285b429f3bb17013ee0f377013a1c3"
    sha256 cellar: :any,                 ventura:       "023d34c17f722f97d28f9549cec80f17696453ad1016590aff518cc251177f91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "330fe677c9a2650d00055f326f89b175787b21e24efe250d23a97e69cfd2c705"
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
    ENV["CURL_SSL_BACKEND"] = "SecureTransport"
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    inreplace "configure",
      "EXTENSION_DIR=$($PHP_CONFIG --extension-dir 2>/dev/null)",
      "EXTENSION_DIR=#{prefix}"
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
