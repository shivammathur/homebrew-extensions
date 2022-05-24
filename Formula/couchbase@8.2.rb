# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_monterey: "2804b24468174bfd9abf04b92818c97ced6c095128c458751de9425de2cae7c5"
    sha256 cellar: :any, arm64_big_sur:  "4accbbb485ef751bafc68021f3f739ec0933458aab04f57326e5e46a3a5b0e78"
    sha256 cellar: :any, monterey:       "92d80e3edc31786f0c5e3f208ead919ea6cbb68ab48e484261d890dc238bde39"
    sha256 cellar: :any, big_sur:        "a4c822c86a8e6ec15f94f3797587042f2f4131f5b98a4bbe606256724679490d"
    sha256 cellar: :any, catalina:       "85623079e95a3073bfb27116f11de57430c43e3ffc66851e376b017ccc08b038"
    sha256               x86_64_linux:   "91e6d2d8661744b46ee6e470ece78137a73fcdb69dec7a112f023c1502f56150"
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
