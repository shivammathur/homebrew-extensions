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
    sha256 cellar: :any,                 arm64_sequoia: "7c3409bda9f66b61c17f24a759e4d5f501d8c076e0e61c0dc01a577ffb38de43"
    sha256 cellar: :any,                 arm64_sonoma:  "ba0df74133bb1e43820e7d8c10453658b17e2deed90337987a0f1c2e9ee194c7"
    sha256 cellar: :any,                 arm64_ventura: "425a2989b6fa98dc994686c553fdbfa3d7329fa3fad4f5107cafc685dde08648"
    sha256 cellar: :any,                 ventura:       "daae65f2976777028a364b5ec20d1e792a84065880c584a41d21d3fef35f6d25"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f93bf307e13b3cfba16cd907fa97010e104c17e47a5afdd84ba96d1dd2309c41"
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
