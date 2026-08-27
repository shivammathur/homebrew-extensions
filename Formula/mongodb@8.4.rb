# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.4.1.tgz"
  sha256 "a57dc6bd18938ac2396086d9eec44bc82e7d17c399844923b04fe4cdff895ac0"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "92878e1c3a9ab8a6ac890a1ee30c7e2479f6bb3c378a387942ef9b8b97cb75ed"
    sha256 cellar: :any, arm64_sequoia: "f89b7572e38909a6fed0bef40e32d402564c62d01ac00bddbc1b3e29921a3ef8"
    sha256 cellar: :any, arm64_sonoma:  "010b0051efd62f9bc7ee4c1228b73ece9e0a9415205a488d6b8fd9bd1acc9222"
    sha256 cellar: :any, sonoma:        "469e279e46a8207036c927a479ce8c91fc9402df4c05549a6fce82ff6ea9da47"
    sha256 cellar: :any, arm64_linux:   "4e9e7538fc3db41e86eec77ec6e76e6713273247002e9c64caa84cb4673b13e1"
    sha256 cellar: :any, x86_64_linux:  "e5fbe00907909652d11abb54a69f96b1306bc55c4db700d9b4e7fd3ab70a06f0"
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
