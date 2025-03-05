# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.6.tgz"
  sha256 "728c466b9c5bf82639641e1fab84de7b690e5ded8ea0a4b1af5bf88919d49fac"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/couchbase/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "a423acfb05179edc9dd885402ac22717686f4ee52d9a4653f0a0c87a925ee213"
    sha256 cellar: :any,                 arm64_sonoma:  "35509966e9f7c90dd8501aa44d0e7fcfdce469363a969770850fa01af9d9f5fa"
    sha256 cellar: :any,                 arm64_ventura: "dd5ac099fffe58ea4401e87a583ac916be5c06981383a0d682e0aa5729422f9a"
    sha256 cellar: :any,                 ventura:       "cd334471ccf4d64a09dad36fd44ee80201d27781168f8f55e404a0ce17d7b5f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "80c232ca3cd9d296e6298f83b5538d95e49655dfcc6cc004abe8ab82f09ce732"
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
