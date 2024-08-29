# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.3.tgz"
  sha256 "17cc469d0eb509324cc43455fd84bf2d9ed9615b75bff2b152d67d77a50368e8"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "b769d4267a4e0d57ad8d1cf9340764828f474acbb818d11819b5dc60c694784c"
    sha256 cellar: :any,                 arm64_ventura:  "603f717f414de3b40308333ac418ed017993d97e6a3517279ace7c582515da37"
    sha256 cellar: :any,                 arm64_monterey: "703d2ca85957e3f71f99ce4324e62f3591781a7c9a6c40ee35b21fd9498840ff"
    sha256 cellar: :any,                 ventura:        "3db5eb65984023a614929485fed9c1dc709d3336e5836c86254101f7471237a7"
    sha256 cellar: :any,                 monterey:       "d40f6ab4c380e1d7d7ff7db86304c8713df407d74efc95e9b3866b12e768724f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2251997d8404326625e94ce6912fbaf8d7a7b7d6412a4008c5ba01dc52a72276"
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
