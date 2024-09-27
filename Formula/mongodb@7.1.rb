# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT71 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.11"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "77aa48ae96f0687da8a3619bc975b61eec881a1a46ab245389a1ac6bb792be10"
    sha256 cellar: :any,                 arm64_sonoma:  "81cca81f84ca14d0dcc04ac2d870e6fe876c4b82ad105adddaeb48311f04b33a"
    sha256 cellar: :any,                 arm64_ventura: "02cc1dfa2bbe52b580c6429d788a238642c617fb98cda80406675b2f6e0907bc"
    sha256 cellar: :any,                 ventura:       "e136354a30f47acce9e8a66056fbd557539ae8a70f406352324b9cbc19fcf2f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7b5c342816a256ee72d33e2ccb283eba36edbcc7391f1c1fdf2c6d045f112134"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
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
