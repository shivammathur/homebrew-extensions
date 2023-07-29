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
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "6907e9282b176bc5df8bad70f7afd7bbd6dcf9380c9610084108d46c9147b01d"
    sha256 cellar: :any,                 arm64_big_sur:  "0d0c214243530ff52d7b1040198ce6fdc4cec2ec4562943c92786da244bc99ba"
    sha256 cellar: :any,                 ventura:        "93deb889069e50d010a9269a7a12fadb53153251286c6c660d6198aadfe76d72"
    sha256 cellar: :any,                 monterey:       "40e02ecccb8f4f4b041693ea4c8f3d94fc92053677f289878c55a96589d066b1"
    sha256 cellar: :any,                 big_sur:        "5e14a6f7f5f1a2356f6c7c466ccbfd365a24955a4cb60a5ac4389c8b2a29f47d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "effcbf6460525204cc63a5205625ce6ee3d6a9022a6ba19f106001a433db118a"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
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
