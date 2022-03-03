# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.1.tgz"
  sha256 "925d7e6005c6e84bb40a25019c12b0ee4bda625c6449769dce7d5b026983f433"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "b0df4e0193a15262de48b9be3f03c2a8ed336ddcfe014975ea8431108167ae21"
    sha256 cellar: :any,                 big_sur:       "16434cabcda279d67a364c228042d601f8a5cd001556c69f7e98036cf0923593"
    sha256 cellar: :any,                 catalina:      "270d2de7f0451ecd24a7e2445299eaa4743cf4419c4a82cabffde4f93448fed0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "14eca352a7e6bf1d42fecf036f3f70a4b2d97ba7de66c518de63b2a9c0cb73e4"
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
