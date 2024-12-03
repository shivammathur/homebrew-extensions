# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.5.tgz"
  sha256 "5b5d830ce2eadb551a251070082b910ccaedd9fab9dc5c554a0bd98b7e50ca5f"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "d833fcdc7d539c422767999d09a3262f9b84845c0a4d35b53d4acbbcfd2506fb"
    sha256 cellar: :any,                 arm64_sonoma:   "1912aff35ceeb7664b502981008ff44d4c689c93dfed33419a509d3446fecad0"
    sha256 cellar: :any,                 arm64_ventura:  "24623039248a8251ef1cc02f34b40e12519385700e7dfc1fd65c5ffa2f65fc15"
    sha256 cellar: :any,                 arm64_monterey: "9de037e4a1c2c5c48ba149b03b511e95b0f1158d772918d2440a83a3eee3d39e"
    sha256 cellar: :any,                 ventura:        "156a7fe9eb922cd8949a50ce3fb784e78f313c623f57140ccefd9e053021f9ae"
    sha256 cellar: :any,                 monterey:       "9182b6cdbbf5cc1df949edc67d5c00b07aa84c9f941034c8c89dcfbfbb3b2c90"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "95a79d4b00b17577393eefcb4a3d5da5cb7d73cff37c4db64bed783b2bb9ae63"
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
