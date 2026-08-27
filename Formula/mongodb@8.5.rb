# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "9d14b5d1c70b03861d7500c8aea22dc8614ba25682b2c6ffe7a0db7b7fc58b1d"
    sha256 cellar: :any, arm64_sequoia: "e9c34ee3e2fe91519ebb798915a65ce91d8cb01e4739be3954a0d20266651a5d"
    sha256 cellar: :any, arm64_sonoma:  "da0cf6ce2a8ada370c8f4884fc81093b7c52294714ee8b586bd058236412c25b"
    sha256 cellar: :any, sonoma:        "54fb0d6eb986cb9520b76b2ab9e10efbaedbf6fb24d2f510d4d200e9ade41b61"
    sha256 cellar: :any, arm64_linux:   "b7633c3067650ecef2e90b7e3da763af8a2fcd3d30c8922f621fc72ff6798f02"
    sha256 cellar: :any, x86_64_linux:  "ea87e0e4f41bbf120e35dd9cc4d03a8e074efec23dbbe494aa51b5c01c019e19"
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
