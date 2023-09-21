# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "408a9d104a8519fd5ec574b713209835fe6819e74c20ebb0d77925224f7e7d15"
    sha256 cellar: :any,                 arm64_monterey: "a8ffe8e66a8bb031afc9eebf3385a891f33c5852e282bda99aa2690de353d976"
    sha256 cellar: :any,                 arm64_big_sur:  "23734ab15a078c310719347ba41d9cfa257e8bf260defe4ecbd48ec847e0b4c7"
    sha256 cellar: :any,                 ventura:        "6d1e9787075f70ee6f157f0780fef14ccbd3023f58e7cd59bd1c0d12007b2d5d"
    sha256 cellar: :any,                 monterey:       "a134446a3ba49be0dc9a9b865d8c3f3bf960e44857eb98776965aec81452409b"
    sha256 cellar: :any,                 big_sur:        "ca765b1dfded3189c9db52a257ce33de98c59b907dfddcf96e089036431aa82f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7c185407ed3cd56096e163dfccb5435a218257ee489b7ddc7c433f40cf728cb0"
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
