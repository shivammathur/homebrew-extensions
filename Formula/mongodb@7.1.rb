# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT71 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.11"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "fdd2688dc51a331a26ddc0dd105c13355a058b00dbe832e3150d5f135587042d"
    sha256 cellar: :any,                 arm64_sonoma:  "7605035cdcc3d85b71bbcbd38424d2bf1a7b92c7103949b8e8cae4c00e4a904b"
    sha256 cellar: :any,                 arm64_ventura: "7712e5c53fa4c315a4af0f34a12b0cf51b0fc750fb831756c1760fd19fab86d3"
    sha256 cellar: :any,                 ventura:       "ea95e288faa9199258baab4eb0a9562cf0436050e6662e73b467bb091d5d4a02"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c13b4c98f6cab241e2946b3beb46d214426fa7d389a16754e7627fd2bdb7c8aa"
  end

  depends_on "icu4c@75"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zstd"

  def install
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
