# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.2.tgz"
  sha256 "68547dcfb05d424c5bcb82d20fa4c41a5672aacf9953e6f301c89a4830f78db2"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d1662aa44e7ac299acd584f9ddaf71a49084390c465123536dd4a2e98fb46616"
    sha256 cellar: :any,                 arm64_sequoia: "14d0c2ec20fbd1ac2bcb1f1727733dedb1242158aa28f4082c75c7a4cb2f8a39"
    sha256 cellar: :any,                 arm64_sonoma:  "864f77ed925f258bd4ad42539a2a59d3138936b48a1f72bf5ec2efe96c23201b"
    sha256 cellar: :any,                 sonoma:        "fcd200aa12baa5ac79f0f5e9a97ac1bc8ea33d9e90ded761239746abdaf70bf1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e4da3978ece7f1534fff71b099fb5c0fa61e6471be084d4e4cf883231ab80747"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e27d402e81e344346b46a7980c2d07f7427c085aeb6a3825bd3de70b459b5b4c"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@77"
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
