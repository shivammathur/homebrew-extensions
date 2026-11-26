# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.15.tgz"
  sha256 "97772e6a0f2019eff7856522464e4432984f4fec470eaae14b807d70809b477c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "e48d3501b9001abeac895c39b86f57d7a6d578f32bff3f5de2b17a1a26faa290"
    sha256 cellar: :any, arm64_golden_gate: "21208c34d5952f592f47db639cca8361d252229a290259b8c85ec2098ccda7d6"
    sha256 cellar: :any, arm64_tahoe:       "ff30406becdf91de856df64e15b55367b01a31df3dd161d27d0c690a15a8757d"
    sha256 cellar: :any, arm64_sequoia:     "3a56f5592646058dc543e9842d1011cb4d084ba05ead93528e1413d9b6f1bb67"
    sha256 cellar: :any, arm64_linux:       "990ac43672685d5b127d1db4b5f683127f0e460a030eed9e58e8baf90b1cc188"
    sha256 cellar: :any, x86_64_linux:      "3dd8461bfcd05bb43561cd9b5beb1311ad76a442cba3ca3967645805812028a9"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
