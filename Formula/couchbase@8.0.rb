# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT80 < AbstractPhpExtension
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
    sha256 arm64_monterey: "fd001cdcebda73d9489db942d1e1b7e2d400124578f38615bc7adb3f92788615"
    sha256 arm64_big_sur:  "3d804f1ed66d3526142242c9959ba505112426869b5e322320c85713d0591fae"
    sha256 ventura:        "fd07f0353a570b7c895b8501b756df1d304aae1a78a16e58fedc10adb53ba780"
    sha256 monterey:       "44eb326c89e44e74e75a4ee3cc94a41689c3120d6663b79a872f01a202bae742"
    sha256 big_sur:        "261acd26e74496c146d9c004355db1c39175b5574c8ed666fe77d6068a5f1874"
    sha256 x86_64_linux:   "cd69c3090877678e44d613d1a0e2dde86b74d7b0083acf32d4d3f35c7757b1d7"
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
