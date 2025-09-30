# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT86 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.4.0.tgz"
  sha256 "328d57e1054a3f073d5ed2c29507871c0fcc5e0c9398e7f1d8227833c054e689"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "03348997eae854b6dabacc28f1f41a2e4ca1d54ace2ccf0dcf98857d6ce983f8"
    sha256 cellar: :any,                 arm64_sequoia: "8de7c4244abb64f6fe2484af2bc356e5eda26c19a01ca346b7014921e6f534f5"
    sha256 cellar: :any,                 arm64_sonoma:  "58715f8a4560458986c258691a94e12e519c0701143b447c53374366db42caa4"
    sha256 cellar: :any,                 sonoma:        "086df3cc700e5f7477923571bdeb2c3b59f32985a12857e48833dbd41426e32e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c16775eeeabe667060c3c44aa56507274877eca0117fb24f03080c18af1d7bf0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ee4a918eaa471399d3153071201c72642298fef9b08cbc88b42685966bac18e9"
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
     '-DCMAKE_C_COMPILER="$(CC)"',
     '-DCMAKE_C_COMPILER="$(CC)" -DCMAKE_POLICY_VERSION_MINIMUM=3.5'
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
