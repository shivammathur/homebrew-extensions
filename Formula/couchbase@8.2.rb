# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.2.tgz"
  sha256 "d93583c9df80b96a53ca02e05aa9b99db7705029333ec7ccf9b65721bb62f100"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "c0a91cd9bfbb9587623090447ae939109c3a8d98f3c7cb198e0c998a3fce8b49"
    sha256 cellar: :any,                 arm64_ventura:  "c5b21c8ecc2e25bc248cc068f4d39d627fd98ee79c4784e668e58328b1f70709"
    sha256 cellar: :any,                 arm64_monterey: "40b041dbc5eb786fb845a8db923a001d880b0e546655a6a36a4a200d95de2309"
    sha256 cellar: :any,                 ventura:        "f388d7c32b30ef61b7b8b0e5bea7e4b165c31c1f77bd33db0e8d665a6d86c16f"
    sha256 cellar: :any,                 monterey:       "07ec28dec80d55596444f2e634da95662121e89609477256c6b12daab871ee19"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c3a630cf5a5ce9c874c91f4cc61f9ed262b4f38167a1117563cce8aeb256419a"
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
