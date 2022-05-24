# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT74 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.0.0.tgz"
  sha256 "caa67e972a8e0f50b920088434eea14671902f253fb5bfb854b7e8d3898bcd26"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_monterey: "bae1685b49e5a12ff0fec6905c897f5e7a43e842e5619437adc0584c7a68e046"
    sha256 cellar: :any, arm64_big_sur:  "28130813d748bb2e13e6a1c4874673de6047a8f5ed2c26c37cfbb209a2934ef9"
    sha256 cellar: :any, monterey:       "b75c23c2a774ff260dc103a9992db7def04a0e9f95a2db0bed750f95995b5fd7"
    sha256 cellar: :any, big_sur:        "191d2cc17a084845520df86add325d47584d2ad869b81598239174ffc0c8fdae"
    sha256 cellar: :any, catalina:       "1b11e84a8a56ff56691845d06b02d933d72c590f5ad91e4babbec1330d978b41"
    sha256               x86_64_linux:   "2348bcfd4920ab598218f53b0394eaa795791e8db47f0544fc0127841550b6a4"
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
