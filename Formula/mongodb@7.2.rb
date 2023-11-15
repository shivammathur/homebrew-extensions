# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.0.tgz"
  sha256 "5e7db95103d73212ed0edf8887d92184baa5643476045cb899efbcf439847148"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "2c2efe12ebbd48686eb9ff8af3e937d53f22c6fb6fb3be5656d4a56e48e3a328"
    sha256 cellar: :any,                 arm64_monterey: "5b5756ffdffa45fe48c44ca0cac06502ea4ffd44a1f0a50e542f29ac8b713d9b"
    sha256 cellar: :any,                 arm64_big_sur:  "0a109fdbfc8c7c9ba368a8001112f0c725f2d7b437c1a32f7c065c0294e607c7"
    sha256 cellar: :any,                 ventura:        "ccf226c600d26228b3d1887bf8cbfd5aad66dd44052a4e090d3f57b0b0ba81dc"
    sha256 cellar: :any,                 monterey:       "21366ddcd175091adf3ad478d416d67e1761d9a9d4e2939268b97375ba1c9caa"
    sha256 cellar: :any,                 big_sur:        "96b76bbb6689bdb714845b86d58cf3e6f3549bd3ee3a506d3fbdf4146ea788ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b19ef3ee133da91c62a96b4eed21c27dee7a24b1be737a2ec01c6cd10f546c39"
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
