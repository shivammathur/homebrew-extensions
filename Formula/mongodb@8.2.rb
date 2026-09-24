# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.3.tgz"
  sha256 "5e5369cd01b47543fb3244917eff17fa4c8c357b0866828d59c899b4e53e6665"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "7543c1387c38340948f7160d39876ef216d863820e962bd6795c72187aae804c"
    sha256 cellar: :any, arm64_tahoe:       "51ca95c05268f3a6aa43d6cc2aaaffae8a5512447331717867bfe36e21e77e16"
    sha256 cellar: :any, arm64_sequoia:     "281778bab48b39cffbd6344c09c4c177e802de5dba09ffec975be2b94529bda0"
    sha256 cellar: :any, arm64_linux:       "6e8e0bbc76edf1da0bf1846e323619a4a320bdd1432b52ba8b0aa6e514570787"
    sha256 cellar: :any, x86_64_linux:      "41692c765b73620969f5e27ac4e71cecbbe975bb95ff6bec7164b686bd265504"
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
