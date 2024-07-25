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
    sha256 cellar: :any,                 arm64_sonoma:   "6db663a03545e98bd72d51596e3325061a57178a7929ed72d2046b8ec917fdd3"
    sha256 cellar: :any,                 arm64_ventura:  "a35d8cce99f93b2cfb82213f0c2ca309fe1c918a866251e5f6ba20ebb5174884"
    sha256 cellar: :any,                 arm64_monterey: "2d33317e16e02911db9c97b0b0496099d5ee504580ae33f617317acd70818459"
    sha256 cellar: :any,                 ventura:        "59f4b9067d255b16087bd23a76d67a5421a14ba6cdfae38fa142fc7806001f54"
    sha256 cellar: :any,                 monterey:       "aaa7a2a5208cdc231d44a462ff59cea9ab56cc591ac8bb831acd41dfbc46bde9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "15e6a611f75778c059f57a7db09a9ba71f0b64a671e79517ebe526148f546a39"
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
