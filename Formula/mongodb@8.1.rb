# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "4cf30a779c83938d71cb693309c0ca75c252b800879b9ba0fac9405db9c3d621"
    sha256 cellar: :any,                 arm64_big_sur:  "571f04698d056038a87b9eca9ea7ad6ae86ee7e2f8d78a50636b581126402fc4"
    sha256 cellar: :any,                 monterey:       "4276a192e5d8850b68fe5a9f97423236269c25ab683b2947fedb6ee55c5f9732"
    sha256 cellar: :any,                 big_sur:        "19580e0921447fc1592e306bceb52a69a15b90eeda26147c10385a220a69f1f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "91fea033795f78b88fb75b247662ecf346e4c7e5880fa56b88443080e971aa17"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
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
