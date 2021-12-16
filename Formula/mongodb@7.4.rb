# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.0.tgz"
  sha256 "0d9f670b021288bb6c9b060979f191f1da773d729100673166f38b617e24317e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "466063b71d1b3f1e41970ad9c165a4ccf005ccc83949260e8532b9ef9de5c2e4"
    sha256 cellar: :any,                 big_sur:       "4708dc25cd35878359ba198f3f94dc5c7a80edee547309d6476e6b1f1b5ff108"
    sha256 cellar: :any,                 catalina:      "5c5bcebf998938ccc100ee57d2a8f7930020efd3878f09c4a72fe00ac3cd9bc1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d47aff4c179474943d1865ec8a8fa0a375ddf944cb64facb5fee2d0795310bd4"
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
