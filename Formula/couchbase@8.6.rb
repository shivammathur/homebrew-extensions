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
    sha256 cellar: :any,                 arm64_tahoe:   "5e18b6af9f2b05f5e5913f40e99ab03a20a6e980d15af12ec2beea3124318f4e"
    sha256 cellar: :any,                 arm64_sequoia: "eff6582a281b4ee36e5677181b09044de7c6f689e14550f4d8e181516522ce35"
    sha256 cellar: :any,                 arm64_sonoma:  "a1386362bff92c38f9a7e546a03d7c2115ed6622300b23ae13b3cd342caf96a7"
    sha256 cellar: :any,                 sonoma:        "95f482d5cf40eb958e0eaec20f241e753f609d158a715f533c3850409fded713"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "11d86f041a86d4bdb5e2b446cf3cf2d5877ddb1878b3e8ea47e17836689d27fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "19b4cfaad6fce966fd33f0fc3b53ec437de50c38c1ba94eeaddf3af650568984"
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
