# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "bb1e3fbcdd9395af7a5c17c9b6cd43ce8a91c11d81dd9d37277c9cfb8d2afafe"
    sha256 cellar: :any, arm64_sequoia: "b6629b0d9dd92e1923fd6c23c3483d345e99deeadce3b5a185a511d4eeed60d9"
    sha256 cellar: :any, arm64_sonoma:  "f1be0546b0a7170c6fe5f3b4cebce7edceb0454956009e184dcfb06e8ac66120"
    sha256 cellar: :any, sonoma:        "a567d4753df953eece8828e537c4839855f8e9abb026866a8ff03abea42594bb"
    sha256 cellar: :any, arm64_linux:   "eaf7c57c33d39754e06509c3e980fda57f77bcda03d2ce4b1b0aaa519cb0bbbc"
    sha256 cellar: :any, x86_64_linux:  "1c920d1733f7f87ab6ab98de0be1d7cec9e20fef0fbd0e185974abcfd27d9de5"
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
