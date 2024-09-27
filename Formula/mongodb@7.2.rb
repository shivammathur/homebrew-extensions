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
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "738cca8aaf183aa25074db9fb52321c90f6e73dd73d05975bc3c78246f2d6a0c"
    sha256 cellar: :any,                 arm64_sonoma:   "b9c4a8aac3bd5a3e927a68dec5890c45f60492279be48fd374d34baebe202477"
    sha256 cellar: :any,                 arm64_ventura:  "af41c26b9c33acb2f36b503bfcc11b73c590e4096f857bf202958e7eadf78f6a"
    sha256 cellar: :any,                 arm64_monterey: "43489abc947a62ce1c5ad3d5c9c4bb7c41a0eb034439cb79c0d8fc05f794eb54"
    sha256 cellar: :any,                 ventura:        "b81b88630cee338be5ca640720fb78da9ba86f0a64d216c1f36588dbfc00e88b"
    sha256 cellar: :any,                 monterey:       "f9630b45a7010121e814e8111b4b9062c9163de9640ad1a75ee74c8c2f8b03c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8eafdd0c5368e60be40e60c2a87bae71041b66da80fc41613a2056789a1b86e7"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
