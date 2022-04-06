# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT70 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.9.2.tgz"
  sha256 "95e832c5d48ae6e947bdc79f35a9f8f0bbd518f4aa00f1cef6c9eafbae02187d"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "aee19e7a3bd55ba1b6408abd31485c96046d98de385163fcecfb63b06ed91f93"
    sha256 cellar: :any,                 big_sur:       "12ef2c326d2780d08971620913c9612961191900b64b4f5397cc7a26bc040bba"
    sha256 cellar: :any,                 catalina:      "8f54d3e197f5e9fc5f454d2d14c2cc46d04a6327685e374e13b9e3a6617bf23c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1d62efe092aabb72c4bcd9a5dab378d20018a3fa9916555161843e7af4512b93"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
  depends_on "snappy"
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
