# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT71 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.11"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "f08d868ed878aa2a60e1b1884c1de1564faa718946675b663c8ec0e103492718"
    sha256 cellar: :any,                 arm64_sonoma:  "69dc2c305232f7bae952d6c55cbfd688d825580a044638e0eb606fb1b2d11c5a"
    sha256 cellar: :any,                 arm64_ventura: "07cf544fbc4113bb2c842ab38bcc77756b57c592e54789491e6684a2524bbacf"
    sha256 cellar: :any,                 ventura:       "431978cc26b8b6c91f983129da168e554868fcb0716e76bd1ce72ba83a9230d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bfce8574002f82fd7ee36af150f96cce305bc2f2b1366c0f8e1efe57ae5c5f3a"
  end

  depends_on "icu4c@76"
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
