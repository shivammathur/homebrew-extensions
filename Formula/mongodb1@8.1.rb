# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.7.tgz"
  sha256 "e4e30d82639d698a174356193f7ff33b101523d16ae769faf66fbb217dfb36c4"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "284cf895e4413e13f855aae77236c91a3b0a09a63751a0d83cf873d61f01ad4a"
    sha256 cellar: :any, arm64_sequoia: "36dbf8a2bd93398eeb1841851c89cb8cbb4945fd1a24e483e1f2d74aca8fe975"
    sha256 cellar: :any, arm64_sonoma:  "3cec40b20f8257c780ac1f32e584a26b183c0610208ddc5128a03668e6ceb134"
    sha256 cellar: :any, sonoma:        "c540a70d2aefd05d9d961dbab4902b95431849f67bb39197ac268873e5812929"
    sha256 cellar: :any, arm64_linux:   "bdf91aab72af17fc1236b7063273c85a593727b1d3dc73e6e223295ecb6c5153"
    sha256 cellar: :any, x86_64_linux:  "b2f1660c38a1e2d7e5e05317f540c0d7dedfb142f3180a4bd9ef12350fa5510c"
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
