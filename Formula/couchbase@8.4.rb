# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT84 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.6.tgz"
  sha256 "728c466b9c5bf82639641e1fab84de7b690e5ded8ea0a4b1af5bf88919d49fac"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "f9f0305e639a86fb194d37268ea6d49c03c04a5d71a0b471241c3838d2ca023c"
    sha256 cellar: :any,                 arm64_sonoma:  "01ff0a04536a63430751ad7c0ecde5b95d82fedb653c2d8b27b455bb88c160dc"
    sha256 cellar: :any,                 arm64_ventura: "c93ba6c1ba38fbf72a3fdfad1616d7e8c15a42a1ce587eb162afe0a6e456acc9"
    sha256 cellar: :any,                 ventura:       "7931d12484b7d844fd87f26607a1240f393f0ac9f81feec42a54371d0ebca072"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3d3b2e3d141baf067707ef74e26aaeb543941f7d5876ba83b105ca9f27cdd3dc"
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
