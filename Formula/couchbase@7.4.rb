# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT74 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.0.tgz"
  sha256 "3f027727615848da928df347bf1cbe7a867f8a362b56eefe8b2457795f8b4492"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "b943f900d7e36940a8b1861848e27f125c2dd6bd487ff0f4e09d54b34defa732"
    sha256 cellar: :any,                 arm64_big_sur:  "7afbbdadd050c3a8bb6bc29996e8a1689310c4705eecd32d47779901dddd655f"
    sha256 cellar: :any,                 monterey:       "d9eb080d8d8811a1fbb99ffffea5fc94178cbd04880b4b9797075ced6d0a4521"
    sha256 cellar: :any,                 big_sur:        "d2edba7f6e4f5662fce556eca8bead1a03e4bab024701b7ac47a83b17a6a0666"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5d805bba504e7c0d2aa05b7fc1645ea8ae9ab12ab554089e6cfd85d33a89932c"
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
