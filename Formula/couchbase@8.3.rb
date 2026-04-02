# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.5.0.tgz"
  sha256 "f31385068fc197516012eed85baf732eb58186a95a1d6da09ca03859f0b71747"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "11926be63415c4bb344c8bfc177b19f5c7d7bdf586dcd6e5bc59bda811f67e14"
    sha256 cellar: :any,                 arm64_sequoia: "9b993e32cd19f86c06f412f3a09667d2b44ba862b9e0c8c7ecd2d9a54c0f54ab"
    sha256 cellar: :any,                 arm64_sonoma:  "6ad73d8f795c7013e94cae833a6ba8e124da5ce87613110fda539fb87f76bbae"
    sha256 cellar: :any,                 sonoma:        "c22e58a548b99b9201270fa9f8d7638d5ca9c2147315e2f79dbfc82d0737cd06"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e6f7c6fa9ec1df2ae692822d9d35edd0ad032d08a4d30a7f2f9744c8d62f6270"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "144fec0e8d16c3c44ce609c27192db96e5fd31d71118620dfc3b4f6bb392a5c8"
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
    inreplace "Makefile.frag",
      '-DCMAKE_C_COMPILER="$(CC_PATH)"',
      '-DCMAKE_C_COMPILER="$(CC_PATH)" -DCMAKE_POLICY_VERSION_MINIMUM=3.5'
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
