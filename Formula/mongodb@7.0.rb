# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT70 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.9.2.tgz"
  sha256 "95e832c5d48ae6e947bdc79f35a9f8f0bbd518f4aa00f1cef6c9eafbae02187d"
  revision 5
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.9"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "25aeffe4be9ba52b9e0e7b74ab30e6b7fbc1f83c8c2739bbc3b8efc99d324e1e"
    sha256 cellar: :any, arm64_tahoe:       "b578e0dc55a80a562605f5e5ae59d8df0b3946d9cfe98ff728a8a645eecda50f"
    sha256 cellar: :any, arm64_sequoia:     "21022b1aa95ab5dd2d2522f7495453234fcf739177645f849d7397de39952c7e"
    sha256 cellar: :any, arm64_linux:       "ed8c87c480fd5bcb036c233159de44767a4ef70b6932c1636506381f2d7bdf78"
    sha256 cellar: :any, x86_64_linux:      "725aa63452c5b862e738f08b50b8d4535c7e624e6613a03d55a34e029d8f4596"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
  depends_on "snappy"
  depends_on "zstd"

  on_linux do
    depends_on "zlib-ng-compat"
  end

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
