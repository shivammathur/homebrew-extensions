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
    sha256 cellar: :any,                 arm64_sonoma:   "fdb97442bcd7b9b152fd6d4f6d89ae78df8baafcc3e9ab1937e94183c884f6fb"
    sha256 cellar: :any,                 arm64_ventura:  "a5603c0ec5e139232ce4cc493b04f5a556a5d44678ad40dbad87d6bd3ea4b95f"
    sha256 cellar: :any,                 arm64_monterey: "0efc5897a175c88d09448c50ce52c42b2b921a04dd1a57cea76cc444e95dfc60"
    sha256 cellar: :any,                 ventura:        "6f4bfb7dc22dd9bcc379577c2402ea506e5033efcbfaa3bed623d34b87564810"
    sha256 cellar: :any,                 monterey:       "97f345187e54e1d6aa8f2cdab3ea750725c3fcccf61248cdb5087529165c488c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "24431a82890e8581816a764273aac65db0fda96925e8f493efebd93dad462b2a"
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
