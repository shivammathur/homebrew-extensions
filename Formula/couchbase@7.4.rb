# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT74 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.3.tgz"
  sha256 "bfca3512e59dffc9f981cba0294387a50a83c1f7e446de92ae44f8d1d421194a"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_monterey: "e5659c6618e417059c9e4c381de8687967f0518347ff8fae8dbad1196b9d26ae"
    sha256                               arm64_big_sur:  "fffb3c971a26e7b8df9449057835d21989d6fdcb834e92a5d1073a85059ae450"
    sha256                               monterey:       "784b1066dc1b76a25a1e65501a7cc8aad3eac2663517bb012c42ca3e85d3f876"
    sha256                               big_sur:        "41bc05d1c156f5641c32d0212c8661ed3ee46d2a5b9404758f8b1ecd05a15f88"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b136ae299a81d9892c3a9014e54e096281c6af1dfc91403131cd86b5389c3f33"
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
