# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.3.tgz"
  sha256 "e1ea11cd3d995ef9f799245aac0762955792308efbc9e93260c3a587643a9079"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "df8891e18964583c74f65656d11983b5add3ccc5f346f563ae1aa562469c7252"
    sha256 cellar: :any,                 arm64_ventura:  "f9ef4e8f3136ed8c873754a4ceb72eacfc78a6626592eaabd1ebe1c636c316fe"
    sha256 cellar: :any,                 arm64_monterey: "1bafa7a986cf18494048b5b51ca01c82305926427a2710a14234140c78e9d0f9"
    sha256 cellar: :any,                 ventura:        "c61db26d03d1969f1b2011d279ac399c3358c0bcaa06f4574a5ef0f607b1fbfe"
    sha256 cellar: :any,                 monterey:       "0ad2457693b78a302a8a5b2ec0e7eeabd07429cbb76f88de824dcacbae2f861a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "32ffc1cc8f6b4798c55af109adfadc024c232b0583ee0106c2b2152e4ed26e65"
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
