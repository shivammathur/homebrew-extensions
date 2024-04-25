# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.1.tgz"
  sha256 "89c3a72ceb4afb1399fc5320129a491fad5dc58b4a482fcfb526e6267e729f88"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "88d1cbf0e34d6bbf85f955b948851c37a8cb1980f2e67525299d17d91759a28e"
    sha256 cellar: :any,                 arm64_ventura:  "ece2f0c603924808e9e3e9b09c78ec727513fcd89a168e2394c4854e3e04f164"
    sha256 cellar: :any,                 arm64_monterey: "a33a9e7e4a8e650eff30a9f5232bb588bf409e11cee1b674935739a9a86d70a0"
    sha256 cellar: :any,                 ventura:        "5c5e701fe904a1de03cef4be436753362635da0fc421f25a60c700caed8b8ac9"
    sha256 cellar: :any,                 monterey:       "f5821ccf0b72ba11db059250613c2f0790a15a694573cc18c7600ea34b2f6f1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bfe96ee1dab9d78bddf1b95bdfdcebafceb1d7b2994fdb63b94e94a3afc11171"
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
