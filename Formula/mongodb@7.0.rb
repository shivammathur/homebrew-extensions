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
  revision 3
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.9"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "08792b8b5512ef0d478238344a39a61a1dc303caa72319d9cf6203c624bb54c5"
    sha256 cellar: :any,                 arm64_sonoma:  "bcd3de111dc4d3b452587fcb08cbb977eae63542af64861832f573c6bca44996"
    sha256 cellar: :any,                 arm64_ventura: "f9a1dce16c6f9166e6e6186ca3cfc6351d6f2bf9b780e8aa431aa81f86b9d499"
    sha256 cellar: :any,                 ventura:       "a58a3e2965793bce940e6f881fd11347062eb72bb3629811c3005838b866a734"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "34d7c145a99d1a40b6c5142de42a54131bf15ad936faae3b39572a6c9588b9cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1521bd7e513892f76fa311131058dc7c183cc5be4b3d9b60197dc290c6a96e63"
  end

  depends_on "icu4c@77"
  depends_on "openssl@3"
  depends_on "snappy"
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
