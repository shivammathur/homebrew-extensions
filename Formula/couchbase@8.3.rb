# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "2e7a749956ad2b62026d311383d3e244a6f61c620881ce83c645c9ec11962a93"
    sha256 cellar: :any,                 arm64_sonoma:  "c6647ac29aa71ad6ef28641f2f48a123a389b3bc4fd54a0fd60db87bb9378688"
    sha256 cellar: :any,                 arm64_ventura: "f5704ffb234797f3901f80a7328bc630d299e6532da2c76da7c77e54bf435605"
    sha256 cellar: :any,                 ventura:       "287bfce580f1ecef500295eccac0492a7099adf18b33b5ab483232773871f3be"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6d97d37c17e85c4eebdd56bdeb73fffa6b852c29db382b192a32599dba6041ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d7fabb7868cdc5e0ae0b567a6fe8ef7fdb07d79257088c448f7669e6e64208f7"
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
