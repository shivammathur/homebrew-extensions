# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.4.tgz"
  sha256 "57c168b24a7d07f73367e4b134eb911ad1170ba7d203bc475f6ef1b860c16701"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "f4ab5e323a91962c41b24ea8d4274bfcef4d410df0db86436ac83122b7c997da"
    sha256 cellar: :any,                 arm64_sonoma:   "4e48c4d803fc1fbf8f825e17fe2a8e9b6a87f610d4ff218c331c79751ad9c638"
    sha256 cellar: :any,                 arm64_ventura:  "0ec3afaacad58f2ef61e48b078f1d0ede0cc4f9f73153637854466196a6ed548"
    sha256 cellar: :any,                 arm64_monterey: "eda9e03501279f112b2848737bbe7bcc90811a38329a1ab5976398a8667cb0a5"
    sha256 cellar: :any,                 ventura:        "13b0ea0718afd8b8eb8068083cd81888e24b4a3bc278b5d79da7b0be83b97ccc"
    sha256 cellar: :any,                 monterey:       "225648085a8fd99e717a868093682912d180ae71764647e10f674d3ce52942fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "559098ff8d9d40bff42a5748875c0751d3105fefe36719ad9b1c8bdcc83af9a9"
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
