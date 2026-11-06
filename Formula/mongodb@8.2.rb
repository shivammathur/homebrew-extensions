# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "3f25eb37cdf56c29fed6ae22c02c8df762fb9328a9c48f8a03f110c607f18742"
    sha256 cellar: :any, arm64_tahoe:       "f7d96305da98337b9a6ef5c86a520c7d1b9b547a219a4e89ee5baafeb8591214"
    sha256 cellar: :any, arm64_sequoia:     "9d83e92ed6e1d74c1a6732f8add73936017b5ec9a185a2a7b8914f2e5d551a68"
    sha256 cellar: :any, arm64_linux:       "45cb8cd8953d6416fa2bc6768c2271b3dd34c7717da07403fff2709aeeee6181"
    sha256 cellar: :any, x86_64_linux:      "168d8c285e1303432aba6f98d2d18cd3197e8a74a95a363ba0eb516e591e1ff9"
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
