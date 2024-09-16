# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT84 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.3.tgz"
  sha256 "17cc469d0eb509324cc43455fd84bf2d9ed9615b75bff2b152d67d77a50368e8"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia:  "4dc6f2d6be001038f458c9657767dd34202ae5074894caa43cefba2faad2abe1"
    sha256 cellar: :any,                 arm64_sonoma:   "115620e86f4babb139b0685de24cace9fe404bb04c7a015c33e2bf339517df2a"
    sha256 cellar: :any,                 arm64_ventura:  "4087554a4bb8b9d2fef65d4898455ed2e2b2e02948b67576161eda6e2e5cb4fa"
    sha256 cellar: :any,                 arm64_monterey: "175c3dfdb68e1001fcfef0e7dec2898284f8627481671d5b375167da3e20a993"
    sha256 cellar: :any,                 ventura:        "6a29ec89379521d15123271357e48f473ab7be1f418e2e22fc9491d2114df299"
    sha256 cellar: :any,                 monterey:       "2f01216bafa3e281051e90757fef39a98a8cd7d38c6c42504a59feaeb7dba215"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "91627abd02c9367bcd31f794deaeed6ceb4fcdd4dbb38776ce8e1e845e6cb1d6"
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
    ENV["CURL_SSL_BACKEND"] = "SecureTransport"
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    inreplace "configure",
      "EXTENSION_DIR=$($PHP_CONFIG --extension-dir 2>/dev/null)",
      "EXTENSION_DIR=#{prefix}"
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
