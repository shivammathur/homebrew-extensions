# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.1.tgz"
  sha256 "2c5b7c7ccf6ca26d25af8487f4028390f0a7dc49efb2eb360a65840e1d6f566e"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "57fb8af9882f0684c05995eb6585443058d822c987b6c4430121a1f70eb7caf8"
    sha256 cellar: :any,                 arm64_big_sur:  "8bd16aa48eda85e39046bc69a5dd5fc0903658a16a75cce9d5adee248cc8e87a"
    sha256 cellar: :any,                 ventura:        "50281115987c939f756eb562c486774f111908f05ae708e8159e870cb8f576da"
    sha256 cellar: :any,                 monterey:       "f301b8e83ae277adee0e57c4c904dc66643e6ce38842b326704c6ce010b455e3"
    sha256 cellar: :any,                 big_sur:        "5e8297bfc5103b0de62783acb2d0c70b74ac5d7f7de930bbe3cdb0f7bef4540b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9ab991eeb0859eb72f3677d97fab5d38cbd4cf1388eda4773a7bcff34c99f0fe"
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
