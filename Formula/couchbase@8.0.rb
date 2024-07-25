# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT80 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.2.tgz"
  sha256 "d93583c9df80b96a53ca02e05aa9b99db7705029333ec7ccf9b65721bb62f100"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "d65cc22641a1ae568c7ac187d2559960e250d130c1d8c902e80c68aebeaaace5"
    sha256 cellar: :any,                 arm64_ventura:  "af54fa4103eec77d9697e21e99316042907b65ceac9b1ab27db3df0920d44bf8"
    sha256 cellar: :any,                 arm64_monterey: "32a3de3787023354d7ec6ff95c3498298d0f51a73584840065f54bfbbc373646"
    sha256 cellar: :any,                 ventura:        "1c9e74e9c9b2f4ba50a1f3349e0cfed7cf85e9b15730d028bf48f05fce34c398"
    sha256 cellar: :any,                 monterey:       "4429713a0b99893bc5879d36c5561bd7bbf4bfdf5b65a9b598bdf13d201ac932"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b0ee3c9100357eb4612ea5f74d7b21e15fa97bcae5cfa6ad5ac75389f2295e07"
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
