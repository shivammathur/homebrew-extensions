# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.0.tgz"
  sha256 "0d9f670b021288bb6c9b060979f191f1da773d729100673166f38b617e24317e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "d1205e8bfc5824b6673c827bae7b34050bc29fc32651a06e6be7c71858ab4237"
    sha256 cellar: :any,                 big_sur:       "f2744eac8c8659405c0df6d3feac1f64d507f8d0562e188c97467970129d5000"
    sha256 cellar: :any,                 catalina:      "8ee6203829019f1e199d9dd5466d054ab7cc82bea7794382b615ace27ae97c21"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "95d1289a22376b7a8409b8d6abed8c49475966b119dc40c7209f86fc5c70df1c"
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
