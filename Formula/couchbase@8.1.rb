# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.5.tgz"
  sha256 "5b5d830ce2eadb551a251070082b910ccaedd9fab9dc5c554a0bd98b7e50ca5f"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "f2c4d8071b6fc6d5069d80bfea162272f12a8ee1e000281e0980352f8d39f2c9"
    sha256 cellar: :any,                 arm64_sonoma:   "b89270bc08e732f5f4c931b580eb5028684c491d5cdb4447b022e9c9d4badb30"
    sha256 cellar: :any,                 arm64_ventura:  "d875d01219c36917845852b5be6a4b65a942b8261466c15898d6f5577285eb02"
    sha256 cellar: :any,                 arm64_monterey: "d8318ff4afe383d5c3078415cc2695e36517d7d840d46f12eb49d8bde7ae234f"
    sha256 cellar: :any,                 ventura:        "ccdc5c4c213515be149d32a36a9344b8c66453d0f8d6c0a26ba6a810d3bb10f1"
    sha256 cellar: :any,                 monterey:       "eacd3d7fe71b782b2a44384ae6c637666d303342c4d74bee080928a8b3ba5358"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "735d1199d0562d012c5a8b4f1298ec3f270d4652f55879d01761ba7c37718538"
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
