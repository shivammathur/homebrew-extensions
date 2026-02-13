# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.2.1.tgz"
  sha256 "b923617bec3cde420d80bf78aeb05002be3c0e930b93adaacaa5c2e0c25adb42"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "79b013a38a028dfb6c1350f048c7b8b5ab26c4a40befcd7803daf07d335a7c07"
    sha256 cellar: :any,                 arm64_sequoia: "9bbac8270e7cb283575d33bf7d2c0a29839500a2abd340d958f23c324cbbec85"
    sha256 cellar: :any,                 arm64_sonoma:  "44748dc7ef3f228123a80d8a904c89f70cec1f9ed75ebd4451c70012b7b272c8"
    sha256 cellar: :any,                 sonoma:        "0fe57dbb4a81de47a63b6442e17f21223e38e8f979e6fbc3287fe08b9d6b6171"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c68176ab6fd0add68eafd39db5088b7891471a87fa0ce4fecd141a1796a5b7bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "334312bbbed507997c13662152bb2ca8373baee739ec94db4e15ed7a3df4419a"
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
