# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.2.tgz"
  sha256 "7d47d1e92c754ca3999d0671b0c4b71878787d65de35f3b0e8c14f6345476ad9"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "c1233dda5a7ed62dc5b8c51980299d4af663325611bd455499e7f89511026b5a"
    sha256 cellar: :any, arm64_sequoia: "b5ba31ced5ee4aa46a6911d31a5dd17c4a05b3653c638b97df69dc87d5a637c5"
    sha256 cellar: :any, arm64_sonoma:  "846c75cceb252bd96dc7b4dc5ea696dda2e79e784af290590f1de8efaecf1fb3"
    sha256 cellar: :any, arm64_linux:   "0fccad05fd5ee2feb2048cca310630e0bb0c777c079fa0f29a5b5dd631942f75"
    sha256 cellar: :any, x86_64_linux:  "4d5bc515951fd1e4dd7cfbbec9123c0185f3eff317b775908c846afa910b3502"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
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
