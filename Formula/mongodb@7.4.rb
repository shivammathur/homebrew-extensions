# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.1.tgz"
  sha256 "614e57594918feb621f525e6516d59ce09b78f5172355ba8afb6c2207c1ce900"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "4bc5ad5bf8a5c2649bfc8a2969cbe1aefb6d72f0e9fc92ce011e8a0d812897b2"
    sha256 cellar: :any,                 arm64_sonoma:  "ee5b7942cbf0ce56a626ca8db0d65feac20a2a41b63e5089db14a03b375a6945"
    sha256 cellar: :any,                 arm64_ventura: "9189ffb3f294fa496bf7d1ba1e43e572add607de3962ea62c86595e6522f28ff"
    sha256 cellar: :any,                 ventura:       "3373740b18d67a1e992b0626e1c4e607a5a69f2ba6cfa20ad3498189fbe0c5be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2f91328e75336744cb7a12804474fb1ff3becaab67d3f826da80db1056414f4c"
  end

  depends_on "icu4c@77"
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
