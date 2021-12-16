# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.0.tgz"
  sha256 "0d9f670b021288bb6c9b060979f191f1da773d729100673166f38b617e24317e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "99ace616b3c983005b75c6b6d3619ae65abd6350174a6731915abafbef259b2a"
    sha256 cellar: :any,                 big_sur:       "f21d52acf9f6c4c97191691d5f541f0235fc8182c654c295a19a72cba800cd86"
    sha256 cellar: :any,                 catalina:      "608402070384f282394a58241aba7826f2df59b243288d1392d245306d773fe3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b40e0d3c916d1f508ed707c82e4b3c5d6bc7d69ce166d58603ab4811f65281c2"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
  depends_on "snappy"
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
