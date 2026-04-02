# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "113bb0b98951a3531bb1dac5a7ba309dde5bdce11a0de7c46a92a5a790270742"
    sha256 cellar: :any,                 arm64_sequoia: "ed02fe2c7eca1957f6df90c0d8907c9e5d11c9784686cd98c440a8ea36b662aa"
    sha256 cellar: :any,                 arm64_sonoma:  "1ef56118b2e21bff9b49961fe4872b772606091b236e62aa22407490af8a75bf"
    sha256 cellar: :any,                 sonoma:        "acb3f1551bcf0fc6dd3066c4b5e02a918f3f98238e9501a62a96396895549035"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e27b058cddeee45e0c2bfc98baed62df0c5aac070b32732a5c1f08996fefa04d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "64f6d719f78072267eeed4a328ba81b9e4b5e258ead3b3f66577ea8225a1b1cf"
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
    inreplace "Makefile.frag",
      '-DCMAKE_C_COMPILER="$(CC_PATH)"',
      '-DCMAKE_C_COMPILER="$(CC_PATH)" -DCMAKE_POLICY_VERSION_MINIMUM=3.5'
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
