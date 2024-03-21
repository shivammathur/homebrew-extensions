# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.3.tgz"
  sha256 "e1ea11cd3d995ef9f799245aac0762955792308efbc9e93260c3a587643a9079"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "4e45402edfacc739a6648c4ade62d7700b0f310434c5dfb9734dd8a9b577552e"
    sha256 cellar: :any,                 arm64_ventura:  "a9d35ec5c022084205cba909e1d2ff7f842d03085ea463684885a574771ce2eb"
    sha256 cellar: :any,                 arm64_monterey: "9927053c95a2c726b8128764d949fd77335dfcc2a6ed83a1008df7cd096c0890"
    sha256 cellar: :any,                 ventura:        "92f2a530f4cd856273ee25ce57b90ff271c4a5c0d24036e5f805edbee3325ba5"
    sha256 cellar: :any,                 monterey:       "b7a506a58662914aa74e9e76b91c31fc3fc7abe0b7c84ef87613d1da1475abb8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "867cecabe362fef68227e0971759b373ea776b03dc1eb1c86a0b07fbeafc0840"
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
