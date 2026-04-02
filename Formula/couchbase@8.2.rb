# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.5.0.tgz"
  sha256 "f31385068fc197516012eed85baf732eb58186a95a1d6da09ca03859f0b71747"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "968d6ec5c0fb86fccf2977869da31ab0a59fceb54e4b04d3aca07080999a37f7"
    sha256 cellar: :any,                 arm64_sequoia: "d9c3924edc1b3af9cdd504a0b07a91d0740424cc5c2c917b16f3aae78c0c7986"
    sha256 cellar: :any,                 arm64_sonoma:  "baa9dfc701a82872956494fa954573c75b9074353860833f71281ade07b77c0c"
    sha256 cellar: :any,                 sonoma:        "1dc2d80026fa2d3df6beec72179ab97e814436043f9c601207e6ad3e4caa7e51"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d1ce2953f2c3658dc1bbee8cb817ab153ff15b98f8aa73457400b601c60447ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b637d5c6b281cef1c50b2b96e7f524f4251e6604babb703de78bc759c4d2d2e0"
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
      '-DCMAKE_C_COMPILER="$(CC_PATH)"',
      '-DCMAKE_C_COMPILER="$(CC_PATH)" -DCMAKE_POLICY_VERSION_MINIMUM=3.5'
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
