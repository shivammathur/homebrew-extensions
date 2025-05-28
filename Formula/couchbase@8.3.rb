# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.7.tgz"
  sha256 "963145f6fa7b1785abbd7bb5171210b222d9790a37aded9f724d06858c0eea28"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "ae41bff46dc6834b7f9c264303a79d692d2a8ce6e549877a4554b159a2622ca7"
    sha256 cellar: :any,                 arm64_sonoma:  "bf393d9f89bbe968bc9ce63b58e3739c426f0169b342effc4692e1412d6e769c"
    sha256 cellar: :any,                 arm64_ventura: "56a5988e0585d2d26259cd4f46583e2743c1472110cf9f3032980c7d2e5758f4"
    sha256 cellar: :any,                 ventura:       "7a90885974d877952a40b7425d1d225b8d0e70338019cc8ec806452dc4af4c09"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4e0e0722c7488cd948506e5737536695dcb86c7c10e0f58f8e2ba526b702c2ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4ec71a94d32bbd0594e2229c04fdc1a16a59469f0a9953d86b0c00bb02e87d09"
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
