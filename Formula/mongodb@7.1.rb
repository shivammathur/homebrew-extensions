# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT71 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  revision 5
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.11"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c8e1e5dc237050e25c2aee4b13246821f9b058531a4ce29e7ce3be65ca88b6ad"
    sha256 cellar: :any, arm64_tahoe:       "4f104ec5d7a40e57b46b193b3dda68c40420953f0f257f35eed5fba9a6336aa8"
    sha256 cellar: :any, arm64_sequoia:     "75d793e8dba7c87444ecee218dcf096e2894cc22d47ccf817b03cdecbe99a607"
    sha256 cellar: :any, arm64_linux:       "ab911ccc5edd21241e14e606ff3e6b0403275577fb882f0fc9051c60118ff73d"
    sha256 cellar: :any, x86_64_linux:      "9892fec3cede3c9e19adff708b9dadbe5f003de840d553e3de47a9df312d5525"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
  depends_on "snappy"
  depends_on "zstd"

  on_linux do
    depends_on "zlib-ng-compat"
  end

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
