# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_big_sur: "bce7e9c58c4f2555012f0284c2cd9e0962582fad973bf32f2a6401b74d455ad8"
    sha256                               big_sur:       "3aa03ade569da8840b83e5646659097b90a1433190f97e69c744f8cc66ab730f"
    sha256                               catalina:      "c18df7ad52f52fb50646ffaf065a889175554bcd5f4c6b7a59786deaed0bae53"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "764aa80ad3172294528218ec9ffd00a96f26ab45faab9e4b670158845828ee21"
  end

  depends_on "icu4c"
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
