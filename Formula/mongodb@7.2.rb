# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.16"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia: "95f5f7584e27679dc7bbb0ca016d4f8c79bfd8ebd9207ce87c41a9bb6aa7f1d4"
    sha256 cellar: :any,                 arm64_sonoma:  "a12727508865ffe1a487ed8607b0a7031356545aaf1bf93c6917bf63645d2f77"
    sha256 cellar: :any,                 arm64_ventura: "70b16e80edd26a3d16248d68c45403c6323117d6c46f4b5d3e44f01d447e3301"
    sha256 cellar: :any,                 ventura:       "f78773099998b211c114dca538ea1cff0bc601d1320ef8c1470332638434ad85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b3199f47691973fb131cd2c1a7061f60c56971675d09098814d5f533b9962b1"
  end

  depends_on "icu4c@76"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
