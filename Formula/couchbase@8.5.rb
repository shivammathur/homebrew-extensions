# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT85 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.3.0.tgz"
  sha256 "7a82e55384c1a27fcfb46802164ff60bf61f7199dc42719bc0ce6a5ccf9922c9"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "160a2eb55ba7560fc2428a779a30f23e4cd4b766e0abea3029f68cd93298ddd2"
    sha256 cellar: :any,                 arm64_sonoma:  "70d1ec1f2b8ffb554ce8a85810b02da7d23b17f7f2bf9e506b9e53de5348450f"
    sha256 cellar: :any,                 arm64_ventura: "d15cee41c2bfdd2118d35f01ed50d338d534dfb155e9f94f1a9cff491a590ed9"
    sha256 cellar: :any,                 ventura:       "43e03efc10575d41ed716b73961f573ecb7255799465a20c3efee6f4ab2b5a50"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "185a59c89a2ba52fa7ed0d10f91379a4e2c49bffe80b5a45daec55a7d08c6cb5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6a3807045874f680c11003d4dd2b8314013bb0d25248f7802a626e005538e63e"
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
