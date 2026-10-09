# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.4.tgz"
  sha256 "41eead0799cc66876b12d10b5efe86268bfc704c1be57a70d49e4bd4bf6c8ee1"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "b19242087348b3b5f0028f097f3a72b33dee9c7a67f970d2c5e9c32263a6011e"
    sha256 cellar: :any, arm64_tahoe:       "86f7a31f65f5ad0617cdebce5231d1d7fb854cc24dbaa821bf49161900ad3b02"
    sha256 cellar: :any, arm64_sequoia:     "2b886eea6eae0d65f2bad063a16493a7ebf0dfcecc3995418c1e119ee3681be6"
    sha256 cellar: :any, arm64_linux:       "701110eaf1c125442c6793316e8b224fe0d038e4133b3330e66b950cac792e3e"
    sha256 cellar: :any, x86_64_linux:      "1b163760f3115f88ebe56cbb1ad4c372cd62728f13e7cc1e76ea9a8edcb4c18f"
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
