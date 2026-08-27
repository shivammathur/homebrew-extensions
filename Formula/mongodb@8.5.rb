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
    sha256 cellar: :any, arm64_tahoe:   "714a4876b56efe57199c49a1a0bcfb9649a10c068b50d80f18f033e64b72e25a"
    sha256 cellar: :any, arm64_sequoia: "2e074831cf28d10b7893c069786c956e991419ca183f64e0fbfc12dad898db9b"
    sha256 cellar: :any, arm64_sonoma:  "aa5f165c08b13323c84e887d0fa73aba9df4fae7f465306d7994af290d52eb6a"
    sha256 cellar: :any, sonoma:        "b16de65102eaebe2df759214682bdeaa8249592d18011bd5e54a6b3740e7246a"
    sha256 cellar: :any, arm64_linux:   "86ae733b60ba12c569a866511ccac030ba787454f173110dfe0eb389415f5248"
    sha256 cellar: :any, x86_64_linux:  "4c50b8d116f4651be10581630e24656e9a71bb70b0d9326011f521a14a99b1a1"
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
