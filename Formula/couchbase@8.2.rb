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
    sha256 cellar: :any,                 arm64_sequoia: "d50856de43ff7dd7d067d52caca7e8633be5ed851342d03841143e4b6791f05c"
    sha256 cellar: :any,                 arm64_sonoma:  "1b9df0db1d370d206cb82a6b38817f345daf7bd30a62f0ab2c71e51f7392f0a3"
    sha256 cellar: :any,                 arm64_ventura: "9980e1b9fb879bab97aaeb7be63b89e48f017d912f8b34df16663d3917158a99"
    sha256 cellar: :any,                 ventura:       "826ee85aa516e7defbff3c2cac305d8ef11fe1b6ed33ac761dbe9d62601410cd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5e0e395cd50b9fde23897a78d9f3cfcb8e649e7b4cf91512ae99263f2b8860bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de57d6e6d4fe1062037f17878d298c72b57e1812a8cabd5d03f5ce4ae43b3934"
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
