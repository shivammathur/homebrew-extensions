# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.0.tgz"
  sha256 "2717abd81cdff4a1ed1f08d9f77d9c3601a9d934e89bc5441617f7c0acd62d17"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "fa2a7abaf636bb893bf627faeaa18b4edf8dac9289e3e78622b423fec12ed9d4"
    sha256 cellar: :any,                 arm64_sonoma:  "3117b83872cc51bdba2e3988cdf75b7cf1e5d2860a18166bbe70d6b251547ef0"
    sha256 cellar: :any,                 arm64_ventura: "032f50509e7b2f31e8f0d27152caa8b56c3cd80cf73746892b5215b920342c30"
    sha256 cellar: :any,                 ventura:       "623f2c3883d155357a7352bf9cad2346d1574c78b36762339fa338f184a21820"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "98b147d398434499a91a5d02090b83f883a103376ca6056900785fba1a9178dc"
  end

  depends_on "icu4c@77"
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
