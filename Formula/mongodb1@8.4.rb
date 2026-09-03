# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.8.tgz"
  sha256 "41f230589370ffa60a23e3443cec6493e556f8a7d74d42ab5d95fc65abe89856"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "ba0949e8fa5a1e4c67e03caff6d1cc6f2921e97947c8d72114199a5c0ab13e8b"
    sha256 cellar: :any, arm64_sequoia: "f3e704871b9070bbe9e69591094d3c25b201cdb9e06f30d24696322a7f5bcaff"
    sha256 cellar: :any, arm64_sonoma:  "649b267e7088f8230c653d8356aeb9f8c154d9e983564778509ec2d484ddc5c5"
    sha256 cellar: :any, sonoma:        "f4bb0a9d7f9b1b956a213441f376c4f29b794e4177ebd8b61ec433b333db6382"
    sha256 cellar: :any, arm64_linux:   "04b0e8b2d3034d1d92b79020e4939af63e62a7241845629d47660366af3aa0e9"
    sha256 cellar: :any, x86_64_linux:  "21eaf964ef8f4747bfec5354a9006b4e4fb42eda0e9e915b697c85701d6fab25"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
