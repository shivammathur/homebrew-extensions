# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.1.tgz"
  sha256 "614e57594918feb621f525e6516d59ce09b78f5172355ba8afb6c2207c1ce900"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "d20b083203a0c811fbf024edd769403d733a9555583d795196706dacdaaaba2f"
    sha256 cellar: :any,                 arm64_sonoma:  "23d53a781e36fd7bda663ccc2cfb72ce3006164efd7fa3c61aa7677efe227ea5"
    sha256 cellar: :any,                 arm64_ventura: "9db3c5bd57fea5f1b7296576b2ea76f340a23dda08b74f8b93e0d11290125e42"
    sha256 cellar: :any,                 ventura:       "695295507167c9a2d7c94d0273c55efb00117290c1b8ccfae116b9edce1eb219"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1034b1a8cf4b55855295e56dcb5be22fe9847e6b194d91f004cadfac841ea89c"
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
