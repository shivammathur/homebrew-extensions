# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.0.tgz"
  sha256 "55775e69207a7f9c43c62883220f3bc600d3e3f663af50000be70ad3ee51818e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "e8dbb27ca1ce4bb6092038205b719811af260841a3832183317742ba8dd25f66"
    sha256 cellar: :any,                 arm64_big_sur:  "5ffc056577b5c315f9d1d9bf9a74f5fd730b6c6a06a8a28fea93feaed56488dd"
    sha256 cellar: :any,                 monterey:       "7d66a067409b45b161a8655b365410ce88f57fe465f6edbbd7a36063e8e018d0"
    sha256 cellar: :any,                 big_sur:        "438a7361d944028110c86a20c159612c622abe80d2e9f2069fab97b1ef9a7ec8"
    sha256 cellar: :any,                 catalina:       "cd9af068b62aa6cee7c0ff6339de4858c1563667b8050f272eb2cab77540b2a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "09c1d27d399027336c705af4edd98fa41ae00405f53659d2be9e3b95c646b73c"
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
