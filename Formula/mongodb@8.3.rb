# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "465828f979f8fc6f83284f0306d68e4b0103b259b6d9b58a784a36df07046b79"
    sha256 cellar: :any,                 arm64_sonoma:  "3ccc3c355f972943f00302e7a3954088612db4cbbfcbc37fcb01b4000d8ef8c6"
    sha256 cellar: :any,                 arm64_ventura: "add614a57fd4c95ee2024e1a8d5d7b6885b883d9d31966f65b32b892e4826519"
    sha256 cellar: :any,                 ventura:       "8969ed26c4655045b7385cbc25b7e13470ee9d04c1eda023a8838b0aa3bcd542"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "766a1d5cff8ae5d0bbb380ebb8db3aa276276b1968e43adef5d9895dffdf119c"
  end

  depends_on "icu4c@75"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
