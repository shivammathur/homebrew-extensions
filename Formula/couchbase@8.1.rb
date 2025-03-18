# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.7.tgz"
  sha256 "963145f6fa7b1785abbd7bb5171210b222d9790a37aded9f724d06858c0eea28"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "3fd7852429fb3eb59946b911511dee7ce527f29c24c390a778e419b37ef57717"
    sha256 cellar: :any,                 arm64_sonoma:  "abf815f04081c0d153949547f830d35b64ece44ed224b2bb6b80d2ff4552ed4b"
    sha256 cellar: :any,                 arm64_ventura: "7f7c74248183b27c4035f22ac9a3d6292a5aa5bf2743d3df52dfc02c8e3b48a7"
    sha256 cellar: :any,                 ventura:       "3ac436b13169c1df2abf15c6c43e4d4dc4c62928e4fe176689386bda0bdcc479"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d07e426155e8491655b83bc83cfdb1dbaf2392795c36438a71f1557e7bb01652"
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
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
