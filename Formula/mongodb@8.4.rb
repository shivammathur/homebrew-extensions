# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "bcb77bf2bcd52d24b69b30e5ce9579546f5e427cafc4579b50b008fff04d8b60"
    sha256 cellar: :any,                 arm64_sonoma:  "0f32fa38b7c18fa9f21bd58a6fbfef53960a74ad4ed8447fca060f4727f16b98"
    sha256 cellar: :any,                 arm64_ventura: "100b8d5d0a3531df44cd09643ec8b15110b71b01f6185261227525bc27f2676a"
    sha256 cellar: :any,                 ventura:       "d1f9b23ee3c90295103dc88f8cf222c596c0267af32c11f991f15cded037839c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "19aead57e8ce90141cf0958efd24b2fc848f72b37b2033319180c98bd43c047c"
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
