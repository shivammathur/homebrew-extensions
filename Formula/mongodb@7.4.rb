# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.1.tgz"
  sha256 "34b7d0528b5c3f2b9b7f677294ad7aa7822bb704ba6583bae99f2bbf79a29be1"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "cc369fe402b86a96d25ffdfb338050534e7dd5f5f5b629d3ed59d4a15b9dc79d"
    sha256 cellar: :any,                 arm64_ventura:  "57d1bf052ed44a08594ebfbcdbf703641bae4d43702631d78e5a110ca2789690"
    sha256 cellar: :any,                 arm64_monterey: "dc04811e2317b0a210248ccd03236ea813c62aba9403115ec59e1370692274b2"
    sha256 cellar: :any,                 ventura:        "078aa833b469d6e8459ed3095decc74a1447429be1901fa03041ccd2e3ba2507"
    sha256 cellar: :any,                 monterey:       "c35eda74983f9e81e2c6df242c35605d052c7c14a17fc6c16545eb0715213e14"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "24bfb1a22f666980c28c464d9aeaddd0e0fac6830ba5c089ce72486ed0832fa3"
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
