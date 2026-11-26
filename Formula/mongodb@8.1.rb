# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.9.tgz"
  sha256 "9ecf4f6005e1adbb0e5c59c55ff2e9c8347983060aac472043ee3b8570e816f3"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "c4a09ca4e97f26703e728f2d3b6e48b3443ac53ab7a37778db68bdcda2280ee9"
    sha256 cellar: :any, arm64_golden_gate: "7ce51d477e5bd824aa7f9ed5afea910096b7a31dfdcff3abd64e6f8050f5cc93"
    sha256 cellar: :any, arm64_tahoe:       "e77711f92b31c9ebe72e83b25c6b3b3ad8059f34e398c48f7463c16b8b623be9"
    sha256 cellar: :any, arm64_sequoia:     "1820f5f18151eab3316b87721b4eeeb6a2b8ab2b72a07c546f0747e8f5e6b120"
    sha256 cellar: :any, arm64_linux:       "0288689717b675087f531bb6180ac1561c82a902787caa6af25b59a062402fa4"
    sha256 cellar: :any, x86_64_linux:      "fd866a7ba2161e7a23026d709a86efd8cd33883e031157930895f7d2fca50d58"
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
