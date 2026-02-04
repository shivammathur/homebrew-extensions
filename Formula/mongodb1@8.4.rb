# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.5.tgz"
  sha256 "b542e9285308dcd16ad4277f62a94cca2910ee57616a5a4f576ff686f3da4c77"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "fb6b1ddb2753f388580444d539d9f877b272ea13c7a841c56762704eb70548a7"
    sha256 cellar: :any,                 arm64_sequoia: "ab4c24b4c8325535bfaf54d2c45f40c2e6b1098822595a81d7446c6d256a0e9c"
    sha256 cellar: :any,                 arm64_sonoma:  "a6f6cd48f62d16dcb6cbb17f7c1c8d200ab2805c99fdbea359ea2c70a3d0a0ab"
    sha256 cellar: :any,                 sonoma:        "ab3a25d30ff8bf5e97f6b691d711c845514124e873e5c81789e85533bed333de"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5dc11ede337c7fa06fcd8b35ba6a11479dcb59d4778e38b5d5c16b85eda91f28"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7e26f17ba90f51ae09d15402402472d34d8ccb2136c9fa12756be209087de6a8"
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
