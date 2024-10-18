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
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "7260944b096f4f955ecb3528d467078c6f019c6edb46609af76e94e5eafac87d"
    sha256 cellar: :any,                 arm64_sonoma:  "5a5729a2c9af87a83e209801b71b22215687c39cfb8ee43c5c47725fefc10bb3"
    sha256 cellar: :any,                 arm64_ventura: "296ffce4e86f947f9df8d7a5199d31582d2c61ffccf9a76f9d74f04e195cfd1e"
    sha256 cellar: :any,                 ventura:       "020fc40f7059180b375276503190f23c7b877bd75813b063ba53c313e0e98c16"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "004ea12ed6994b42929c7c6dfe088a0ba01f9db0d69c4ce63077fceb85540218"
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
