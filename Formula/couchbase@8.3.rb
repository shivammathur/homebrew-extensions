# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.3.tgz"
  sha256 "17cc469d0eb509324cc43455fd84bf2d9ed9615b75bff2b152d67d77a50368e8"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "4a8f760632bbf35f844e1837a0b0a5549671212fba1f7e522ee53e4b19ed7058"
    sha256 cellar: :any,                 arm64_sonoma:   "a3eaf760f0410a5c5273136fcc18d002b7a89f7089a48b6b07beef67b2c90909"
    sha256 cellar: :any,                 arm64_ventura:  "c02e77cdafd14fb14bcb8b90236af5f30cb1cce9d1dafd73401ce620164bb10b"
    sha256 cellar: :any,                 arm64_monterey: "336de4d619bb041d8d88f2444dfdee5fd69782ddfa1e77d9beacd52f8930822b"
    sha256 cellar: :any,                 ventura:        "79a31d92bf04604ba12c883d45b9d6781b89c454bad284538b832ee57878cbe8"
    sha256 cellar: :any,                 monterey:       "b2a72dc3e33b54123ff904cc083fd9f27cf2e20ab2c8e656e2a152c17ddab04b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "104fef0d81a591bd41b8e298591b0e862a02daf7776afeb8e42e38235b615f17"
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
