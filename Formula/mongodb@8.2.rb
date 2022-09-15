# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.1.tgz"
  sha256 "bae2a876fdcc13d6cd0139fb5b2aefd51c9d5c84a6a4fc53bebdbe3f162d835e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "5c3c6b959e7a4103ed65ba8b28f433e5e1a1f5b70e3cf99d88731fdb87fcb981"
    sha256 cellar: :any,                 arm64_big_sur:  "77cc32bcb7629fcffef7a2c95ec25c002b07fab6a0a3f128eb7c8fc4f93f18f4"
    sha256 cellar: :any,                 monterey:       "93358521c61b10ad6790f9381b7ff77189b340db0194f5f3e136ef16002a34a3"
    sha256 cellar: :any,                 big_sur:        "c6c25b0b5895bf88b1bba79b036d16b8f1ecd285f04ec4ef562a088ce519c318"
    sha256 cellar: :any,                 catalina:       "954335dc5b9e7a9f9ccbb9ceb997c23a2a0cc47bd1f8333e26db0a52d9c482a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1ac4d019887c9a8489e325ded52ff2b1225563779b820c801a5ec14b3511d7a9"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
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
