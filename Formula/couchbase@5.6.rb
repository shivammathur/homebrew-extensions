# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT56 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/php-couchbase"
  url "https://pecl.php.net/get/couchbase-2.6.2.tgz"
  sha256 "4f4c1a84edd05891925d7990e8425c00c064f8012ef711a1a7e222df9ad14252"
  head "https://github.com/couchbase/php-couchbase.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "8621b8896455e5dc1438e19e19717e290f5de75e33f7da640f953e25103eabfb"
    sha256 cellar: :any,                 arm64_sonoma:   "c1e6b4dd7bdc994f07241d9e2b9b38ab4c8aaf106c8a36694ab86275bf8c39d6"
    sha256 cellar: :any,                 arm64_ventura:  "f81c4d9b9580aaa6e1aeaf7b59759e3dbff0c5e98c00b7ae231e37f2b9379d78"
    sha256 cellar: :any,                 arm64_monterey: "a2ee8cc72279d5272e62f9310662ab8c43fdcb38ad93ef4c4737d1b4f8fb7ea0"
    sha256 cellar: :any,                 ventura:        "cd7ae60d0200d590232745b2277f20264fd89f1de98c6df23c66791194bf9937"
    sha256 cellar: :any,                 monterey:       "b96a303252cbcdc0a69f8aba8f317bb17b7248fad553718f5adc049503fd8cea"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "80a9783d518cff83da9915513050afabcf6b80b1ff763c1d318f4ea21fbf167b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "258d370a714338fd4bd339bbe18490de6e338a0dfea33c4afced03c01555511d"
  end

  depends_on "shivammathur/extensions/libcouchbase@2"
  depends_on "zlib"

  def install
    Dir.chdir "couchbase-#{version}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-couchbase=#{Formula["libcouchbase@2"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
