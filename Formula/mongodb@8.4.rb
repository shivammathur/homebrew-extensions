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
    sha256 cellar: :any,                 arm64_sonoma:   "44cb9973b73144c81c83f1cf0bde714065d831ec4f671113d92e58f4469bf641"
    sha256 cellar: :any,                 arm64_ventura:  "8326f10a77c2f970fb83a62373676e3033913024918fc9557d3326bea0af103b"
    sha256 cellar: :any,                 arm64_monterey: "7768ef9f605760ae1312f53c2ee5e1dd73be544585b1cecbe56fe37fbb536848"
    sha256 cellar: :any,                 ventura:        "7e79b3975b18f7980f60a1178990ef4070db8e4582772de6ef725f5eaf79b2de"
    sha256 cellar: :any,                 monterey:       "25719e6825c6d8c51271b725cfe88862a1f2fb3b1081b93ba2318a1d4bc13943"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a38c24f8dda43f9340bf58a788fbc8636c6361ef099e148573f798b0e174a8ac"
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
