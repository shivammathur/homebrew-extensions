# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "44b569a1cbcf89da409f0226d7de566551aa10feaea8fea1beca27a3d8c1ec43"
    sha256 cellar: :any,                 arm64_sequoia: "1ad33df79d4010fe42575d9bf863d6e0729cce6d741f1fb8dfdd5bea4eb39351"
    sha256 cellar: :any,                 arm64_sonoma:  "cbd3859f5a3fdc155fdc26cd25a6c12aadfa42b847bafd7857bd29783a02d3c2"
    sha256 cellar: :any,                 sonoma:        "c42688f542fb00dc86544f77020c50a433f4300caec0b156930b6002d8786d12"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4af31e00dc5dfc7e58bd8d3a38c0e1fd38d9f027c8b6c9169f46032eb4c7c068"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b9e4eb7d364ffab25dc6662dc9d2135a5d829ffc5ba65a89da966a5fc8faa90"
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
