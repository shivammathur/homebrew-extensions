# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "cf059f2f17cfb89279857b375aa72baa4768013b072972cd42f7e4f73656aa6f"
    sha256 cellar: :any,                 arm64_sonoma:  "50c9b0e999b6e624de947faa186a470152bf80984176cc060210c457843e5579"
    sha256 cellar: :any,                 arm64_ventura: "f9021ca69e4861b5b5080fd8e56958054f6d594a4df89ad2c7ac877de78eae4a"
    sha256 cellar: :any,                 ventura:       "87f5fc6f1fa2c471880b9ce4fcc14ae569262b7747d6039f24aabaddc11176b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "010711b5d370246e738b624cc0913487bc51b7ebc95ba8150253339e954aae25"
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
