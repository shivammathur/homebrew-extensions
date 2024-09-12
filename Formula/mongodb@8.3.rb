# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.4.tgz"
  sha256 "57c168b24a7d07f73367e4b134eb911ad1170ba7d203bc475f6ef1b860c16701"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "5a969b9c8f750edc18603969b1f433b03f1a4efe3c9ae4c3c5f74dcff1b469ea"
    sha256 cellar: :any,                 arm64_ventura:  "e9f918e52d5f5ca5a04b43929293eddc9362946e10b49649be2623ade78bc15b"
    sha256 cellar: :any,                 arm64_monterey: "fabcb723c2bc6e4c057a67c990272d9c5e62cdfa7bea1aa4b40477124e01282f"
    sha256 cellar: :any,                 ventura:        "40d341437c3458ad87ef44c58d8e1f89b257ce3a3e1c52b150be6970928863ff"
    sha256 cellar: :any,                 monterey:       "e568648649b86b8271790104862baa51e42e767f04cb7c4c700b898b89523d4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d6b496333f7f2661ceb8ae5eb86234ebb28045627ad58170fbb4bdbcbaa86f8f"
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
