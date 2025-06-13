# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.3.0.tgz"
  sha256 "7a82e55384c1a27fcfb46802164ff60bf61f7199dc42719bc0ce6a5ccf9922c9"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "59bc4ef85ab8237a18fd9469ec32b99c4ff8c63d5232dfcaa9bec5abc1e645f1"
    sha256 cellar: :any,                 arm64_sonoma:  "076e9ac6e10b55cd296dae4cc8106d2e81ae7e853ef0b6ee97626dda3ddde384"
    sha256 cellar: :any,                 arm64_ventura: "831a69506efcced70f511d9d0f5be1794c26215d4f16431bb7ec7d27aa759dac"
    sha256 cellar: :any,                 ventura:       "60ff8e5828d830979973792798e6e207c54c63ea77ce9773f758ff6b58991018"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c892248a463e2875a461d461d3b11696a794a62c9d6f86694736124ac100d604"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3e8ad97da5da435f509ed75c784c76f90f5cfdbc1fb3ac5b627605ca6eb99ebc"
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
