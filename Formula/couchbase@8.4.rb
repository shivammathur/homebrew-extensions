# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "73104d6f26326f25bf06f0bbc8c1f362120371b5b9e9069f61e08193a99121ac"
    sha256 cellar: :any,                 arm64_sonoma:  "778900703d163b4399af835ddf88e1461f1ffed1230f11d510cfda317d650293"
    sha256 cellar: :any,                 arm64_ventura: "085862f355aa7ca75e9499779cdecc38eff3f835508baf31cb0ec02b97c892f1"
    sha256 cellar: :any,                 ventura:       "454055dd95b044e63d0fa01b655eef90b71b0a738883335320447a6f1af5468a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d428234a293bbc0b69667905a11fc82ffc8de6df135c3efc26ce5b29cb74189c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a4808c0a59b9fb4f712f14c5f3db13b7d2caf7fb484ff77e6a103492859aa1a6"
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
