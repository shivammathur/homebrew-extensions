# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT74 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.4.tgz"
  sha256 "80ba7dbabb7f7a275907507186ecb27b559e64082a22ba1ad39cdd129d383ce5"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_monterey: "4608e2e6668919d5b8f2bd48175576ec0d63fca5594db39fab2f848cbe5777de"
    sha256                               arm64_big_sur:  "fcdc66a33277c18626b8b31fec23a77573d9712658dcdc533d467b28ed77ca00"
    sha256                               ventura:        "8cb8216f6c57b42a323c76ff48fa900c47e86803587726437c299ae91030c406"
    sha256                               monterey:       "a772c89e61bb398edada807b64670bde58767c3ddc8ffc6cc023f4905825bb71"
    sha256                               big_sur:        "7a3eda9a63a2984f4450a18749b3a049a01aed84c6715288d5fde51c2b65d31c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1ff4b220382bd1cb07b86c46a4466a6db46a84432755ddf4e2ac363f0cb5a4dd"
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
