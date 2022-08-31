# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.0.tgz"
  sha256 "55775e69207a7f9c43c62883220f3bc600d3e3f663af50000be70ad3ee51818e"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "f1e13d35dd4596a489e3a1c6ee974cea031b72f1f68e41dc50e0af843213cbf1"
    sha256 cellar: :any,                 arm64_big_sur:  "f70f24be74439ba2159544d27c14f767bca7cedafee3ca9ef65112de35804734"
    sha256 cellar: :any,                 monterey:       "6803c59ba4d499d6a504b093577c20fb97243fa3a8ea5dfc7163a530e88c9b34"
    sha256 cellar: :any,                 big_sur:        "028dbe0cc0c6ac3ce924feff3cf47c30d8af69cdaec8d9ebd31b73eb950754ca"
    sha256 cellar: :any,                 catalina:       "60863104007cec634e30548362702918df40ce7ddf68c87211cc0eab1220a644"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4708caa6f135306c5651cde7e92174cbdb1355474d05f2ed0348169a6486d159"
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
