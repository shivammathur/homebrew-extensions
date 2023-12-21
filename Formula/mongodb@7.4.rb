# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.2.tgz"
  sha256 "84081b780d48af884d47f0339800c3666c664c66f0035c66d43a34a10fb67376"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "13039d288fd94deefbc93f3453a22595c7302c96ce5732b057323fb7ab5899a4"
    sha256 cellar: :any,                 arm64_ventura:  "e354f8b124eee709492954faa812fbe19f7a9a08652a4bf87d0ece44eb84995b"
    sha256 cellar: :any,                 arm64_monterey: "2e5a5efd52bb712c741e9308db612c8329b629c76259edda1351d0e25e552504"
    sha256 cellar: :any,                 ventura:        "b8be8272d366e7378f48ebe64a2dd717f846440b003802a02044652d3cb54332"
    sha256 cellar: :any,                 monterey:       "8f372602b27f6e529d070e83a953ff389bad7fca2a3aa0b32b729789caa094ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "537194d47bc346246168bfd09c8c2b6d4fff209c1f1690cc6b0f969feb05931b"
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
