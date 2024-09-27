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
    sha256 cellar: :any,                 arm64_sequoia: "a77a066b5ff443c8c0a382210f9e4a2a0c25cc303c7d0890420e33cbf75c2074"
    sha256 cellar: :any,                 arm64_sonoma:  "d0dea9152fbe22f31691ced969fe652cc7f4c1dd00299f3eafd6a9eb4aa875c9"
    sha256 cellar: :any,                 arm64_ventura: "183c997407e10db5e183cbf85eb9b0900649d94528398512d2215197fbd017ad"
    sha256 cellar: :any,                 ventura:       "86d42f109e7ac173aeea3d4bd0eaf3611360ff2b6496deef664655c63c049a4a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3da0da6fd5f352fd1f62d480b18f1c3a5a687f7e3eb450aa6282c5449c440897"
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
