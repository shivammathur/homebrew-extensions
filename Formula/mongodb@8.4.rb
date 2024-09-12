# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.4.tgz"
  sha256 "57c168b24a7d07f73367e4b134eb911ad1170ba7d203bc475f6ef1b860c16701"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "ee6b31ae511461b9d9187a578167bc9f45c2e91707c3ede7d3700a38f3238eb9"
    sha256 cellar: :any,                 arm64_ventura:  "5bf30c3981b436b0b31e96cf7a03d25aa63d1a4d1dbc4fd15fb7d3a372f45c6e"
    sha256 cellar: :any,                 arm64_monterey: "758a220728fb0af19b1ed8d8e0492917cb3a5bfccd4d4faf2f14f44269bd03c1"
    sha256 cellar: :any,                 ventura:        "8ede0fdfc06c7ef421d0fdd85f1c01a7f9f3ea8145d7ce8fb2f570dee5c453a6"
    sha256 cellar: :any,                 monterey:       "fb2d31c351bfbd0531085cc345e26d1205cfb55649732ed22481b8cf0da05487"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aeee440598fff39ce485068d61fdb1a9f99ee178283218bdacef0f2c8fbd2787"
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
