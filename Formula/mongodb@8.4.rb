# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.2.tgz"
  sha256 "84081b780d48af884d47f0339800c3666c664c66f0035c66d43a34a10fb67376"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "3066cf9c230ba28b9ea6d18b8be779f097b3275ca56b3bfcd7775947c990a659"
    sha256 cellar: :any,                 arm64_ventura:  "46bfc4627e3753a748f1e53c82f59cbf663533cee019a5629958a66e8fb0d0b2"
    sha256 cellar: :any,                 arm64_monterey: "d11ad2d6fdb01faa7cab16fc99b48b2d90b0dabfc699f801b8b9eaecd5456062"
    sha256 cellar: :any,                 ventura:        "3dcbac65e146131b87c6f5e1004b419f301dfd93787b3fdf44a23fe3cbb057e8"
    sha256 cellar: :any,                 monterey:       "bf53faf4686f8d6ebd6ad064008faa4372026ddfed4adf08c9d70b573a896f46"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "056bb8df5116a29160da24dd374de4f6fbca4c079b26717e5d94de8ddd548053"
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
