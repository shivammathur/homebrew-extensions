# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "4decc3eb654265c21ae08997962474500b0de98ec71a0794d0731f25d6c4d499"
    sha256 cellar: :any,                 arm64_sonoma:  "28d5e066709608b33545132373964a2aa7e19066a6673c6d8448413a9489ff07"
    sha256 cellar: :any,                 arm64_ventura: "1ee61214e4189e5bb1ad3578263fd58980e9124b37e38492105e06e655494ca6"
    sha256 cellar: :any,                 ventura:       "1c9eb70165c09fc02448babb94ffa74993b110c2d19404cafe17cbb0acc4b83c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "47f6f68ffbeca1d16514a2a8f28bcab30c2315dc675d57f6ee6d43f25c17e3e8"
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
