# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.5.tgz"
  sha256 "5b5d830ce2eadb551a251070082b910ccaedd9fab9dc5c554a0bd98b7e50ca5f"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "4a33940530e7d3eebc6ba5f6555e014fb64f2c2ab2194c4af6b5d152f287a237"
    sha256 cellar: :any,                 arm64_sonoma:  "a45efb5d34f1dc10c22c7e1a478ef2c5e93ea705c501e67b367e55ed01344ddc"
    sha256 cellar: :any,                 arm64_ventura: "ede9f6791e414337d6d2a273121b5e5478321d598d928d85f9ea81345d2d2819"
    sha256 cellar: :any,                 ventura:       "39b79b89f696523f522178326f78cd2d981b23e0323d263c78763e1a6f74eefc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4da18c6c29dc0e666a2b4382497d7d4e102b5a9842ffb388c189dfe6860aacaa"
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
