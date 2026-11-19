# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.8.tgz"
  sha256 "64bcb151b4c5c3f17dc1dfd949a35aed2c10b6230332861a5ad7aa9cdff44b2a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "72879d9d7f894565f4f5241c60c174812fa44f84f9a2f96bcfc1533716b6b4b1"
    sha256 cellar: :any, arm64_tahoe:       "cdd5b00c6cce557d20ec1d285a231313cbefea7aee7ab011b342743248d46c97"
    sha256 cellar: :any, arm64_sequoia:     "18a84badb706c78c3c6107621e7cc9bf1a1dfdf457a083ad4175abc3c46add0d"
    sha256 cellar: :any, arm64_linux:       "674df5f9058d9b9b12ddf8d22061ca71db4a12cde4b3e930396907af82bf491b"
    sha256 cellar: :any, x86_64_linux:      "b767cba0cb4e57af223269bccf5cfb7ecbd1f6f319f6f9aa623d52d04b62341d"
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
