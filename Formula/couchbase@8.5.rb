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
  revision 1
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2530e6f8bbf773db797a6391b29304ac64ce7fb9dec71a89a5591d6553b02c0a"
    sha256 cellar: :any,                 arm64_sequoia: "35058e5428894078864552dca27f4fcb352bfa508e1abf82abc4a33bf212b579"
    sha256 cellar: :any,                 arm64_sonoma:  "301d4356804e8c54b90cbed697c7a262e6ea081b30eeeecf4e7f983ee043ae60"
    sha256 cellar: :any,                 sonoma:        "20777015a3edecd4489821fbdde1203bbed4f64570fb84354cb9f2e11ad9d1c5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ec0448a172719b9f15a1f109abfff572548dbf789d9686cb074c961d812ea1bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e4bae31b90b79e57f7ec2fc46e4626edeced36e0a367e24fefb279d3886fe73b"
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
