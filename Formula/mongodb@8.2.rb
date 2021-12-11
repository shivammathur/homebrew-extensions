# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "fa46325e44220fda6789405be94f5031c14703f599bfe218802a6cc696376db3"
    sha256 cellar: :any,                 big_sur:       "73a6387e6009149eebe42d8f9d566f8b30e7f3fe9274285194736931984e704e"
    sha256 cellar: :any,                 catalina:      "b12070a09c157ee688800f478592d1406a58048ae5be5242f480eb296874956b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "46f5b8a5d29056d0dc6be2425b3129142cf47c1dc0b7df4b3593048c7a59607f"
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
