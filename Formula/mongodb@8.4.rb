# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "727e104288c131cedf9f717df33bd2eb62716f7e4b9792c726b441100780aa2e"
    sha256 cellar: :any,                 arm64_sonoma:  "130e1c1c6508dad4ffe50e3a1e881cf69f51880eeebddebffeb497c50cc1b003"
    sha256 cellar: :any,                 arm64_ventura: "0c3897db5d9d70f380f179929f7060c909cb5e0e10cfdc579ae6b73ddfcc9d75"
    sha256 cellar: :any,                 ventura:       "56d84e0b2532aaf33c8a654c20bebe5f1f9c1d4451f866c8fd985828a68df840"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "24fc5c1272860f4df6cccb351df93fe41e71b2847e5eba41e99a216b5eb127fb"
  end

  depends_on "icu4c@76"
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
