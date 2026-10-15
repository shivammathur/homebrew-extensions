# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.5.tgz"
  sha256 "0eaf84ff709f73183d80597f31ff02937f6aefde01eb895a0aa19334a290cec0"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "6037d7a5f5af7a7df4eb4899c55d02c5ee56ef0c29a3b87e8bb8cd5041156ba9"
    sha256 cellar: :any, arm64_tahoe:       "01b1e0e3ba1e918941a4fc908bdadc7bd288d37f28a973aea667f518a3f7f79d"
    sha256 cellar: :any, arm64_sequoia:     "64af3577bf58a8c9f6ddeb94818b0b59d1fde8099eb4b6b11267bf39ae75adc7"
    sha256 cellar: :any, arm64_linux:       "ef87f232a368d0fd4d33cb74953efa8f4ff1f34387c5e56f5f00adfd7a581c57"
    sha256 cellar: :any, x86_64_linux:      "83d94da9fe1c6b51559b52a2badc789ca4ec730cdffc44dcc0ddb21519c7a514"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
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
