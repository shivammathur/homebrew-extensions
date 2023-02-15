# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "9ce958ae52ec220673fcbea7c205174aee316ae60b0d10a1fef7b1c2b7291180"
    sha256 cellar: :any,                 arm64_big_sur:  "9d88f6db785642e85fdef752b5b4dc849ca5f13e5725b7d4384dd9a0e11ff681"
    sha256 cellar: :any,                 monterey:       "02526b91b3a9b99b30ea0c034bfb509f31cbbf8dcce048316029b0a923a7ad4c"
    sha256 cellar: :any,                 big_sur:        "4c73d533f7190b92dd7dc0222c1fda8a5c6fcf4fef7a9aeb6ff3ad6deb49cbd6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b813c7b8feec029737ebc67681f277933f9c9d3a37617c419961e963958cd283"
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
