# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.2.tgz"
  sha256 "84081b780d48af884d47f0339800c3666c664c66f0035c66d43a34a10fb67376"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "b99a121dfe3a00384cf611f97afed32d6269ed1d61d859010300e23090b6c79d"
    sha256 cellar: :any,                 arm64_ventura:  "9521c24b425da2ff67a59c44d2868b822670b6a9cfe5848ed6765940c5676447"
    sha256 cellar: :any,                 arm64_monterey: "a0cd29630d17200c10cdf93482576d1660132a7344088b16d53ba481b256d1ab"
    sha256 cellar: :any,                 ventura:        "bb3b22094eb37bec447cb46813f611a8d8aba3f0a6de9f1fea8f55c4c5a36781"
    sha256 cellar: :any,                 monterey:       "253f597becdcbd8f55f1fe0cae76363b9681d060de5ab669a6d1e1fa7f0d0a43"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3959bb7df30538386d34f85deb4e2529c176f44254e652883da4caf631133298"
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
