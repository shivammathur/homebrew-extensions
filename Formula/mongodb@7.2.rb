# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.2.tgz"
  sha256 "6f7ca35b997cc9d75431765e11f675bddb634aaa9b63b4087181fa99b9f2aaaa"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "dabf916a3c111e64d9bba57531fc83d8bf0c95320a7ffa94c1fd741a55f78d4e"
    sha256 cellar: :any,                 arm64_big_sur:  "6f47f2e619635dfc656bb46897a200345f22888b2e334516e78b278537404f67"
    sha256 cellar: :any,                 monterey:       "650e807b0ea3ff4d187a2ce65c768cec0649c1dc25c782b6a91c3e7101ef2449"
    sha256 cellar: :any,                 big_sur:        "baa5d7f97f92618852557977ccdb9ab39fe125def9423611dcb84a1702e329f4"
    sha256 cellar: :any,                 catalina:       "fd4909de8f60c7c37bbb73b5495b7c710de92664aed714775907e302f5bd5c26"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0dbaba489036ab825c8ea97d9d4fb9aa6f1719d595f4384033ac9b551b51b682"
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
