# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sonoma:   "4828329b8fce09e95713343b6e5febe41f25b6f59e6e3540020dad095f2d482b"
    sha256 cellar: :any,                 arm64_ventura:  "9319dc0b0869c57c34a89e3da2fea12a1bac08dd1df09b64f36f7e1aeb02b80b"
    sha256 cellar: :any,                 arm64_monterey: "a7b76834347b01fe0f6327abaf2cca07fa499a9e0206ac6db753b4b8a86a1cbe"
    sha256 cellar: :any,                 ventura:        "0dba51f0912266f76dc691ccc225b06ab6aa743f2efa674f5bf5df775d23e6b7"
    sha256 cellar: :any,                 monterey:       "5376746af384cf49fb01ef1b8ea7e7239eda98d7249a8a07cdbe238b297feeff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "860a9be768489609df859c262169ac22e24270d9b267056e6af16cf737bcacae"
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
