# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "fa8e7da2ea773fb78bff7ffb155cd17ed2e455cc201bfae53fd0c9a6f0556d01"
    sha256 cellar: :any,                 arm64_big_sur:  "1ccd55b5d49a385e289539d13cc921cfaaad262808105c28c63fb4fe8d4698b9"
    sha256 cellar: :any,                 monterey:       "7958c2302566bcc1acd6fcc42ab52c0b962506a79c4d77c389067f845bb6143b"
    sha256 cellar: :any,                 big_sur:        "7314d72ebfaaca889fdd010aec7dcfd2bb4ce5e187568c54209b76ab82c07d61"
    sha256 cellar: :any,                 catalina:       "12a10b019641b018d19ba9b1147e98e93371c85c454fba842e3b772fb9ef39a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1aef431985ccfbd546f703eca312d25a9f332531e38ef38771fa7d4693493a69"
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
