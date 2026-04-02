# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "94676aa30722a5b9b730107c0d6e7f45837cf922cd53a5081706f555d81ea9b3"
    sha256 cellar: :any,                 arm64_sequoia: "dfb5d9ca59da1d7953f8b2d7cee0d62f3cfd4a28dc13752b1310b7db150434bc"
    sha256 cellar: :any,                 arm64_sonoma:  "ad1898d5d5a3749c8d8677cada0b3ecfbbb9c779948eb4e9c007f108ef8d0e3f"
    sha256 cellar: :any,                 sonoma:        "737fbbb6308db1aabc4020a545e98b70cf7ba190582cf7f2c0c6d3417eb29e90"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2e75c43d096d7bbb53d42b234bd39a6c2e6bd35a25514d4bb16731bfbaf45c3e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4c57cb96ab51488c1ae9aba173b393b06c3fc42d7e89ed673de00d103490f6f0"
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
