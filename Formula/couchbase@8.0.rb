# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT80 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.5.tgz"
  sha256 "5b5d830ce2eadb551a251070082b910ccaedd9fab9dc5c554a0bd98b7e50ca5f"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "e4721ff76600423398809bb54318bf6f55b6d6a368b86352d887e2fe4a426dc8"
    sha256 cellar: :any,                 arm64_sonoma:  "ebc583dbf7406e71820d653e2cf62b6133912e808aa5f86b1972aa94c2825ff6"
    sha256 cellar: :any,                 arm64_ventura: "7bd50bfd5cb22921c55f7f2bb56ef99e2eb0c522153aea3dcdcaa69ff6b30fb7"
    sha256 cellar: :any,                 sonoma:        "09cbadcf66abb90dd6e6ac157a36909e81473fc06cad412bc2ba223f9c2aefbb"
    sha256 cellar: :any,                 ventura:       "94447579e17284ba803549f739d3549cea78ecc0afa7a608effa73961c69a5a3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6095e0f6892e39c9bc8c2ad2940c95d95b54221fb26d9bf45d8d150668faa1cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de593aac837cae391e5fb3b729df9628fad21170ae13c3d8c46ffe7b2c0be4a9"
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
