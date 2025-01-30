# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.6.tgz"
  sha256 "728c466b9c5bf82639641e1fab84de7b690e5ded8ea0a4b1af5bf88919d49fac"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "ee1a2f386205d41929b372ca3d09d06607842477923ea94981686226b37b0cfa"
    sha256 cellar: :any,                 arm64_sonoma:  "9f5f495c62b942fd9b9bf83f84185d4004650a01c40783ac09ae2b152cdb65bb"
    sha256 cellar: :any,                 arm64_ventura: "64686e08bf8262dc44c8765d9283cd848d85dabaa5049e126b47c020684f913a"
    sha256 cellar: :any,                 ventura:       "2238f77c8fc2c133602ea56e472c76939e85995134f2ea06f85e04d796b38b92"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c7ce28d3019548d6062418379f97f2c39d1c2020d4f4cc077e30eb9e631c2b96"
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
