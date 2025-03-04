# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "32f21ac5977429cf17b3b6f8ab1fc2e23b61a1f09655f9d0120ad680f53a8e2f"
    sha256 cellar: :any,                 arm64_sonoma:  "3fb470277efd1ca8d265e53bdd3c8af4febf17c568542d0c66fc8422e3a979c9"
    sha256 cellar: :any,                 arm64_ventura: "2981a2e4c8bcb9c2d8da88ca5d3d51da4e39630295279fe67f1d29acc707f534"
    sha256 cellar: :any,                 ventura:       "4595c63a6c0233b698b920ad68d9bf094687c6d5e944b786495c3842ccd9cb32"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e1d765b9032dbbab09ff147a3d3851dd111162f7d3d17af1a1f52970ad1c0f70"
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
