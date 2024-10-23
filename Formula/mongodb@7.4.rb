# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "9673af0e390f7ee704391e6be8304b2914be83eaac680a66bf5c87d2e42fe8db"
    sha256 cellar: :any,                 arm64_sonoma:  "1fa60b8adec3977f19b60b1b4a07798b8f5fb7f538c2de9cba34af8d07ac324c"
    sha256 cellar: :any,                 arm64_ventura: "011a123d0c6e1d60d2165975d1a9d1704713c8d1d0a51b09970816c3eb6f8a88"
    sha256 cellar: :any,                 ventura:       "f44d90d95331f87c266f65c83eea1d66d8ceab4cc30e058d20e79e33a238fd06"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9d168c5d7ad9c1be443ac3d1af37ae9f6906e94d7a49c15cac5466a3128cafbd"
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
