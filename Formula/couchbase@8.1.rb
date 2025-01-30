# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.6.tgz"
  sha256 "728c466b9c5bf82639641e1fab84de7b690e5ded8ea0a4b1af5bf88919d49fac"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "eb305699c5a6a250791645515ce4b38b5087fbb885199259b6a24cdbc18a1619"
    sha256 cellar: :any,                 arm64_sonoma:  "048627d3b78d467fb87aa6edbcfbbccd6b70dd2d98d481da9739695b9748e647"
    sha256 cellar: :any,                 arm64_ventura: "c06eb9bbd37fddc931869e4ae1dfc85984ce5a839b59cb311eecfdf73e5cba7b"
    sha256 cellar: :any,                 ventura:       "f2b2b03e44208d1fc581adc8a63f56b6ab2989dda395ecbdb4192381b84cc966"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3ff2b460bc08d1f3734e05e687d06fd6c59a55654e7bb0f814f8fb5c954df367"
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
