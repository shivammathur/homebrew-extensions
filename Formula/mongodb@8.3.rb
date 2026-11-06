# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.7.tgz"
  sha256 "078773856f4066b56738fc13950bb7ee16b5e66f727fb41d3fbec6043c78fd32"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "1281107baa9508da879de4ca4efcd67b86699667173606992460ea7474cd5fe6"
    sha256 cellar: :any, arm64_tahoe:       "a1a2a43d5ceb6b7f1dab63b4fe7b7991cf5f0d7a2ec5c31dfba507815667b168"
    sha256 cellar: :any, arm64_sequoia:     "0dd1febdefe7a3c6ff38f8a68d82d4c72ac296ad21c2d3c6ad0289cda7a11805"
    sha256 cellar: :any, arm64_linux:       "17a234943b408ebbaa67ab71ef27a8a8e8f044784305609383a87f380fa864db"
    sha256 cellar: :any, x86_64_linux:      "f4b75aca93ae172ece98b374c36a14f7b490e2b0a8fa1a2181e4df8b9c2183b0"
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
