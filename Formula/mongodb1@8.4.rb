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
    sha256 cellar: :any, arm64_tahoe:   "5889037369f7d76fc1cb73a534d9a3312dc79f0edf95d4321f760e6ceb72a029"
    sha256 cellar: :any, arm64_sequoia: "914150dd2ba9a71ea788cf62e601df8a6fb843781d5f1aae7ca686604bc404b4"
    sha256 cellar: :any, arm64_sonoma:  "d0899e71508cab96d25c869f8e5021f2d1f933a6b989ba55896cef7b23b80b2f"
    sha256 cellar: :any, arm64_linux:   "deb174effb34720407d483de2ebc983f33aec367ffc91205448b23fe118cf3ac"
    sha256 cellar: :any, x86_64_linux:  "dc644abf855825483e8e8b7a7134fcf51e8c85765dbea20481e4f8f6053ae79e"
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
