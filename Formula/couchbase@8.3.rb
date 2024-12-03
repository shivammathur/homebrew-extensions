# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.5.tgz"
  sha256 "5b5d830ce2eadb551a251070082b910ccaedd9fab9dc5c554a0bd98b7e50ca5f"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "9a91ca96b7e7b9ad17774f53ec765096ea6edc09e7923e881b6a7b146068fa27"
    sha256 cellar: :any,                 arm64_sonoma:  "ac7cca9675ae2afd3ed6e904cde3cb89c749be07d634d983bd525ed943dbb0b2"
    sha256 cellar: :any,                 arm64_ventura: "26e2e1c87b80411184eca48b20c13c5c322f31eb2fef2e6c81759f58859715b5"
    sha256 cellar: :any,                 ventura:       "e86671225427972662f40c4cacd189d01967028b48beb9d3ef5ac5b111f39d6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2dd370ec284b7149c19c56efc65a9940962b693737213823c5866420af4ec3f9"
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
