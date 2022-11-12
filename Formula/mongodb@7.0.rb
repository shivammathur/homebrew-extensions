# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT70 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.9.2.tgz"
  sha256 "95e832c5d48ae6e947bdc79f35a9f8f0bbd518f4aa00f1cef6c9eafbae02187d"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "022318abc88f42d2a3d24e379414b49894a4371f17b3e3b26ad6fbceb96f3ab6"
    sha256 cellar: :any,                 arm64_big_sur:  "fa3e5e1eb530cd4f6a4db540df7100342ee7faecbbb544a789c5dc30f17dddc8"
    sha256 cellar: :any,                 monterey:       "30c8c6da93a34b3c6fd32ab4f41bc209bad4735e4d6cbaa466362f532ab84584"
    sha256 cellar: :any,                 big_sur:        "aead2852d22d04a45f1e3894ce23cbba2753645b1b8212b1e3fa9b38b5f917f4"
    sha256 cellar: :any,                 catalina:       "e0cc1bbaae13093918dd287d897435c788a1ec5d67bb66d1a2b36b7fef62ee74"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c2b65e6a33dac626a968d9ef5e3c0e4d5b0ade7a3090032bbc5dbe4eb7bcf69a"
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
