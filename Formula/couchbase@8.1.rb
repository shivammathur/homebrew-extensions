# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "0e56a6853db4cf639b02fa5f067249897a77bf128c3ca777773c6708a56e4eb2"
    sha256 cellar: :any,                 arm64_sequoia: "20483a24c52b1beffe78fb3350cd91b520b5c2db8194b9330c87601caab650d4"
    sha256 cellar: :any,                 arm64_sonoma:  "dd6430ee87c29e21bd70c34a63fae38e9a33031e086132dfd56a9b7776b02b14"
    sha256 cellar: :any,                 sonoma:        "63b612def1a27dd83287a9c5668917f1b2779499343d591462ff39950f95c740"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1bdef7308e78095d652c7149026beee6522c597badb01cc2462c539eaaafffe1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0e2cafc13d9180980b2b3fa6136c1dd2684514117c8d1ce4ae26591a075ecb64"
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
