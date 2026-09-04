# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.2.tgz"
  sha256 "7d47d1e92c754ca3999d0671b0c4b71878787d65de35f3b0e8c14f6345476ad9"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "c84310b956225d2249348a221d016b6025a0f45c0c795b5e077ff92d979b1712"
    sha256 cellar: :any, arm64_sequoia: "7fb4be080d76b04766dd2aed717d7b42fe288e38a9782d132e0a1c9cad9f9db9"
    sha256 cellar: :any, arm64_sonoma:  "cdcbbb332a42328ee7a2c96c6575686322f99195e9f78c746d2afa4017c11ba4"
    sha256 cellar: :any, arm64_linux:   "70baeb62c35e63de70a06dd5a24cebd326cfb0a94d4bfb81e4a946a84124db66"
    sha256 cellar: :any, x86_64_linux:  "c9c0896b75e8ca3954a8664ab76cf4c109b7c4eca9cae1e00512074b323130a4"
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
