# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "b86dc94b4b556531cdf6487b388dd9a3519ae9049f14a2c6f48531fcb532f1ff"
    sha256 cellar: :any,                 arm64_sequoia: "b40d4e0c7704a9ef8d4301f724e10b1a883978612d4d1e5edd583508445e8020"
    sha256 cellar: :any,                 arm64_sonoma:  "fae89dc4d908d0fcfe8d9071d4900ea2b242deed66a0011d63bb22951713d9aa"
    sha256 cellar: :any,                 sonoma:        "d34d038429017cc9d3caa5bc2a74ec46a68951587366cbe9559a6f5e3b0e759d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d693e4a042f47978d5a577f0df569580cf2665cacdd292dcf7969eae3050a5f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8a30139a60ae3b9c91861c51b1de0dbea942ac35a4f8ae40021f5f41650b541a"
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
     '-DCMAKE_C_COMPILER="$(CC)"',
     '-DCMAKE_C_COMPILER="$(CC)" -DCMAKE_POLICY_VERSION_MINIMUM=3.5'
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
