# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "47c11f1337d7924ac9bd3e520095090ab3c899b2b06897c37eb0039f7b6f61cd"
    sha256 cellar: :any,                 arm64_sequoia: "fe3fc40afcd92676aa0d3d9c92c505a0a5de46c0a3f6ca24dce4307e6523ac57"
    sha256 cellar: :any,                 arm64_sonoma:  "8b6c4c3134e31737e2d21f25423f61023f9c941f3e911104d811e026b1321615"
    sha256 cellar: :any,                 sonoma:        "3c7d74e4b125068c5528de519ba29d38aa4958f15fa8c6dfabb1ad5519bb43d1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c22773b1e34f77ff7fb81fd308573d7efceafa57dba348b4153e20c818d9137b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9c2d048e6791a5c9ca1a79d8286eb4fad5798aff2a709eb53d533cf5a0242045"
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
