# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.3.tgz"
  sha256 "bfca3512e59dffc9f981cba0294387a50a83c1f7e446de92ae44f8d1d421194a"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_monterey: "3ff07911c10f781002e7090ae42e74b317b0651b9d0ca625e90961eb3f295ef1"
    sha256                               arm64_big_sur:  "214d456cd153f31b34c3df7674693c2121457633fc5ebf0083320c3ff7222864"
    sha256                               ventura:        "ffbb056f28155c76af5aba0d427e354143bd7cbd59479003334519b472ed4a38"
    sha256                               monterey:       "f082b67fcc070a34305f779d7288bcaf5ae74514121ed70bf637887f0184b8bb"
    sha256                               big_sur:        "7699fce1b3e25a8b668eacd8e80b76122c1d87e1a0a897fa26cf753c97803a59"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5dac3a89d3a8bc7d4d5a1c2b3058339d558dcfe37118e1c26e12dd01c4b9961b"
  end

  depends_on "cmake" => :build
  depends_on "openssl@1.1"
  depends_on "zlib"

  on_linux do
    depends_on "gcc" # C++17
  end

  fails_with gcc: "7"

  def install
    ENV["OPENSSL_ROOT_DIR"] = "#{Formula["openssl@1.1"]}.opt_prefix"
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
