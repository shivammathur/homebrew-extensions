# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.18.1.tgz"
  sha256 "f957b71154052fa9706ce703f4f8043cfe2655367455483798b59269ebe9f135"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "6d6211f1887e341f4eb39bac7fa127c7e73b67e3cc56842a5d469b5855d779bf"
    sha256 cellar: :any,                 arm64_ventura:  "45c4a9263db4578fc3b50fccaddf82460a6127a41564a9f1d8c88762c8d5b80f"
    sha256 cellar: :any,                 arm64_monterey: "0aa9120a1a00dd8e967393ed00897852df2ba98c3adafbf7dea3cdf355a1c368"
    sha256 cellar: :any,                 ventura:        "ad1c42a8cbcdaf858c3ea3103afae4f5612d790c8f35cbd4ea3118d332f6d342"
    sha256 cellar: :any,                 monterey:       "bdd1d33ee9954d1ff8f18a247d2f404bf31d2ab303de4f815b0b8686f1425b5e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "81659bf11635e7448a12c22d3b0f517931ddee16b6ce0f8997c9ca30d8a16f14"
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
