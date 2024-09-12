# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.4.tgz"
  sha256 "57c168b24a7d07f73367e4b134eb911ad1170ba7d203bc475f6ef1b860c16701"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "5993c23b30cf31b10d1ebfd3bd0bd8df93eb07fc9bb06b600552f6fa0b8653be"
    sha256 cellar: :any,                 arm64_ventura:  "f3ea4bb838fb74ae4c5b9440f783d0522e493c7b57baf42ed008af6ff2eb0e4d"
    sha256 cellar: :any,                 arm64_monterey: "c71dfac4c6c990a1a0d1590a8b1f7354edf589d0ba3d15e7bb26ecff411145f8"
    sha256 cellar: :any,                 ventura:        "ca7f9c73eaaad86a77c273ac0e30d538291720c097c72efbb0f317c779771a94"
    sha256 cellar: :any,                 monterey:       "d0e27649ada066a543092e1bcf6d9a627f8a7f0b86c42e79c06af6af8966602f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6746473a36aef43f4bfb9f2575ea9f32472345c6d45027a412624e814149ccd8"
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
