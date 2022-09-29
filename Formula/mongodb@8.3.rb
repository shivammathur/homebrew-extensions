# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.1.tgz"
  sha256 "bae2a876fdcc13d6cd0139fb5b2aefd51c9d5c84a6a4fc53bebdbe3f162d835e"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "08e1a0924500b7617a8be79c515974051c99c6fa60facc8304f2a9f68f648287"
    sha256 cellar: :any,                 arm64_big_sur:  "acb14552c6558f417a627d22d73ca06ad8d9607b44924a948332886fac7d54ae"
    sha256 cellar: :any,                 monterey:       "27f1c638bd8757ea56765a996b9b5afd3a42a0683006ac035c3cf324e3a90333"
    sha256 cellar: :any,                 big_sur:        "bf673ccd0822173ca1ba3c65e466385ec8efbca9dcd12497963b9c45defc12e8"
    sha256 cellar: :any,                 catalina:       "8c05fe16d00bc83ed389f97d55e488c08dc87cdb112bfa83cae23d4e0d203284"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "18e7393f206d4d710e136433543c489888fae75e0f6fd5392d42899c27a56386"
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
