# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.2.tgz"
  sha256 "04a82c33710d36bda551522f33067d334dd20945f4db680cca5485d10e8aa5c7"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "9e4c990bd15363561bce819e60468f071ab3fac0d0d1e67b10378e3f6591d3bd"
    sha256 cellar: :any,                 arm64_ventura:  "1b61b88bc014dd781c7d93e749b4b515ca15e2d86f158328779d0dd9d430a884"
    sha256 cellar: :any,                 arm64_monterey: "6009a73bef8ea337f898cbf3075ff00a4a402f5ed08bf239c01881f044447191"
    sha256 cellar: :any,                 ventura:        "973a3b5dd9a57123fab73c70b3f7e948a7a4d354d047e059e64b4723d97f78b8"
    sha256 cellar: :any,                 monterey:       "7c7241b41c89e7ee1f653fbf4cf5eaa31d46b42ef8bce9b01a6bfa3466244399"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "76576e2db73c1ef017c71270f9402e95f98a85e9a68acdb51247563ba56092fd"
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
