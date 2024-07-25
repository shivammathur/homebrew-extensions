# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.2.tgz"
  sha256 "d93583c9df80b96a53ca02e05aa9b99db7705029333ec7ccf9b65721bb62f100"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "27fe98af45907cdf106081c031db464a694b74e7ee3954507f46dc3ce06050e5"
    sha256 cellar: :any,                 arm64_ventura:  "2cc8df95addff1d8f1398d850e38c7c9ef71ddad7d7011767f1e3bc6458d123f"
    sha256 cellar: :any,                 arm64_monterey: "e9e9cb5928ac67aadd280f1e8467cb8d124f6c46acfb7f0b250ee70e5663c63a"
    sha256 cellar: :any,                 ventura:        "9dbcd42fb782ee98b6c24e464f35be95cff962c564e290f273fc96c47429ea9d"
    sha256 cellar: :any,                 monterey:       "ce7864f4d43a9a6b77bb74b59aeda7d32295bb5891e51c64c3b07d3a725272c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "94711e69b24650d74759234e13aab1c045337547f7f75a8cb4b4a50aa97bea8e"
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
