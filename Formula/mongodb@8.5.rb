# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "9457e03cf792fd133db94541c7e241e98a9435f3b2881861812aadbdebef8018"
    sha256 cellar: :any,                 arm64_sonoma:  "3abec22cd2b90daabb087cea406d6f8b61de2e5d3bb8f111e03bd02c4b8131f6"
    sha256 cellar: :any,                 arm64_ventura: "a9dee0755acdc5ede14d384a8f9dbcd458d785e18a2abc088b85d71181f16700"
    sha256 cellar: :any,                 ventura:       "f8756c85193c89abba33f331217761ced662a67c3cb4258676c01aa39f887079"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0c97c5a859cb109be584b96e4c006b4ca35e8379e1b41b6dd37dcdc8700f0be5"
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
