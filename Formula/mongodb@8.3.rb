# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.8.tgz"
  sha256 "fd0d34b4c530bad6dc4e0be61e23c118a3cc851ad879e088d6afca25b574916b"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "255e318368b0a240d5f80be6fcc1307c3a9c373558d42c912ce7c87a9273c710"
    sha256 cellar: :any,                 arm64_sequoia: "c3d7391e798af5c5a372fec2f8d80b70baeb1faa2a301ab269f816fad81602a5"
    sha256 cellar: :any,                 arm64_sonoma:  "dc6dba19f41d3c99f411ae9ecefd280f05fd5d6b2eec1cc143b4f88abe7a14bc"
    sha256 cellar: :any,                 sonoma:        "a8fee731675d2ef9717bb9e632ef59207ebc286c72c802ca7b40503a43d6ca41"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "15cb4662c6c8a70fd4e7ce3e401802b58f3522536cfaee65c7098e1dcd8ed134"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4985689ec5e091bb3c3e619a0b707ede0c00eae5be7ef0ddae6241eb7ecb366b"
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
