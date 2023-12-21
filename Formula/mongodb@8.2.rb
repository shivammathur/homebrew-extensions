# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.2.tgz"
  sha256 "84081b780d48af884d47f0339800c3666c664c66f0035c66d43a34a10fb67376"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "393235f801bdac6c29a843865f56a319e985740ba6cfd5928d58070cfef346b1"
    sha256 cellar: :any,                 arm64_ventura:  "9ec3bb1587a15392ffeb997cff2a719c6e2ce500ce8217fc435a2471f1da9044"
    sha256 cellar: :any,                 arm64_monterey: "f645fe204965a768d889cc38cb958a5bc4822fa063c7e10ae8f8edf769006350"
    sha256 cellar: :any,                 ventura:        "9f9875d4299741e3d48a2a2ad8238920481b1d71b89969234f7564bf3893ba2b"
    sha256 cellar: :any,                 monterey:       "cf3c01b4c981a8d86e7278db22941e5fa886dc014db2f248581c2075b42d95c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5eafe33ad37021a61b72c2fafdd228c5b60b6c32eade77f4f6603d85c6a42e43"
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
