# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.1.tgz"
  sha256 "614e57594918feb621f525e6516d59ce09b78f5172355ba8afb6c2207c1ce900"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "95b9a660a4eac5924c9a394bca49d478a65f788e1393e8279ce3a2fd0158695f"
    sha256 cellar: :any,                 arm64_sonoma:  "0c0f37078fc2ad2456a38f68413bf01320b0e26487523f92566fc73a71e05961"
    sha256 cellar: :any,                 arm64_ventura: "838a7b3b28f2975e9122bb8be201e780c4cc1624fc15effc104735fbbcdb3cb8"
    sha256 cellar: :any,                 ventura:       "e7603c88d190a20b7af3df4c2685aaac57c7e101c10e986a879d44b45845b278"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58f3144d181ed99abdba84b0606eb00567a248b1304cc4bd618c42a9579101b7"
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
