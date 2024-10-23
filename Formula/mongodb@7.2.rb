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
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "c54b0103ab159ec25e69dfdf3bb544637688b7fbd529e5f65d0b3d89a1baeca8"
    sha256 cellar: :any,                 arm64_sonoma:  "50fea29a3ca032ad67cca18307232f6abc9107126a0b7abca0338290a3681c9e"
    sha256 cellar: :any,                 arm64_ventura: "180b932ba6854eb67d10ed19cafd7bbae2ae03538ba62bfcdb50bee91bd614d0"
    sha256 cellar: :any,                 ventura:       "f930082d03378cd60832ffb5953d0f9c5a4a7bb6650acd2307c279ab7c481203"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e569f102892fa0743e90a44e8814425a9fcce6985cee75db2eb15336b0ea832e"
  end

  depends_on "icu4c@75"
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
