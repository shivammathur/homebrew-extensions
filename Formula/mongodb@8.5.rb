# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "c427f6bae81a240026221510579f717e8e92d1060b7f101bac6c88e5eca326bb"
    sha256 cellar: :any,                 arm64_sonoma:  "20b58e6b81d9f4e0df3f6ee37c7b4e1d146a9c82778cbecc0ad301ecb525a93c"
    sha256 cellar: :any,                 arm64_ventura: "077c3223468b4d36f005ce0d703c4b33e629b6b30349bcfc1687004cbae2acc3"
    sha256 cellar: :any,                 ventura:       "5e6a840d743968ea36139432e4122dfa7eed476fe2622cfee9fa5b21c8fdf7fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "43642385591dccb2a0fa1ec849afaa26cd9915d08b2ef5d3912a5bbfaf14e42c"
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
