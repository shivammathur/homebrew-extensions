# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.4.0.tgz"
  sha256 "08d0d298f0e4c6190a4f8c1f1e23cfbf5d64a1063370b35368bd53012025afa8"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "74962ce36b122e1d96f7c3dfaedcdcc8cb9a194b14ad0461e5a11a967536158e"
    sha256 cellar: :any, arm64_sequoia: "421c458db0967f40a29067750f3b3dfb3d2b0edfed10c3e7c673ae8480815d5b"
    sha256 cellar: :any, arm64_sonoma:  "9a2c992b0967326e0faf68f586a31ab894f3c67c7a4eab974fdff2e2a44d87a6"
    sha256 cellar: :any, sonoma:        "deeb5e67f7a6f016779d9605c31da538185c50d43a46f3a970aedff121b96ffd"
    sha256 cellar: :any, arm64_linux:   "ef653b2fd9f70c298c2e40e7fa482cb56ec675fd3fefd2aafb7fa374dc5087cb"
    sha256 cellar: :any, x86_64_linux:  "8448ee5be25e84d27653d329525452276888ab82d4c2c367091cf82ae968f6ea"
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
