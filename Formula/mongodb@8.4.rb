# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.1.tgz"
  sha256 "34b7d0528b5c3f2b9b7f677294ad7aa7822bb704ba6583bae99f2bbf79a29be1"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "8c67eb34c87233827f1dccec47ef1ece79a8967743e03f1df54ddf2ac7c72d2c"
    sha256 cellar: :any,                 arm64_ventura:  "d0e4f267b70c3e03b7e6355c54de160221b4f8ddc780dae2bec4e23366583232"
    sha256 cellar: :any,                 arm64_monterey: "c430f7134c5f199b1d2609e699c64663144a2ace22df4e2a3f2ef2e15543bc2d"
    sha256 cellar: :any,                 ventura:        "38718aeb475b445744d4c324338c6ebd4e4beccdf699c3824e132766808491c3"
    sha256 cellar: :any,                 monterey:       "2eb16c215ae6a62718b00f201a3f485033c4e500c247ee5ee938276c6241c584"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "35029940aa6f3c9a76a9945e9cd79c4c00b3df6cf5aa7bb55c0cddc67365355c"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
