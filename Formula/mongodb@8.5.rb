# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "933a5e4b13bf97c383dbfbddde96357e03f3a7e083efdc9141fed35cb0f42340"
    sha256 cellar: :any, arm64_tahoe:       "bb712ed979bce8ff02e81d45cf0f92697ca993e010746a4fcad97a4fe384ed49"
    sha256 cellar: :any, arm64_sequoia:     "11806bb54868c46ce3d046da99bfd482f110d96c062714b896a10da3b4711f44"
    sha256 cellar: :any, arm64_linux:       "49606e04bb44431efec924731d4db98ed70e1d842258d81aca38adccd1b85821"
    sha256 cellar: :any, x86_64_linux:      "34b6f81f1ab2893e5a8ba3fb06f687250324cbc00337c78387c9ae8bedcaf4a8"
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
