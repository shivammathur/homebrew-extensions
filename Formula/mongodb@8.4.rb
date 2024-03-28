# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.18.0.tgz"
  sha256 "6c36290441d72f2b0520bd8ab1d50c80de4c42240db6ff502e3db04c29bd8b54"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "58fb3f77dbbfd3cadf20fb4598695c236bf8ee85db8731f1108040e3bc826776"
    sha256 cellar: :any,                 arm64_ventura:  "29325b8fd4b206e8489b3a511cac4ab8f0196aab34b5eccb496b04131790411c"
    sha256 cellar: :any,                 arm64_monterey: "e434a87eda09188a66a92afaa861ddf2ec3525713060ea1e4641486e0de179f8"
    sha256 cellar: :any,                 ventura:        "f212424dd18105e8f30a58083fb396a541e1923b9427d699160273989fb4b7a7"
    sha256 cellar: :any,                 monterey:       "e5b63eb3587f2fc8f8041f30c1146fc21e7fae35b4e2014ce5a58dd8e019b5f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fad280c7e59a7ca002ae13c39afb9b4850c457d868e645873b5867881fbf50c8"
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
