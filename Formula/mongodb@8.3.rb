# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.5.tgz"
  sha256 "0eaf84ff709f73183d80597f31ff02937f6aefde01eb895a0aa19334a290cec0"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "a2a5eabb9e82f4f6a51ca482b27f6ba6da588efc9108cfcd6b5f768d577c7952"
    sha256 cellar: :any, arm64_tahoe:       "112161f3441e5cd3ff568c7175c9562b08b0f77916819a75c9a2e02a9ba85de2"
    sha256 cellar: :any, arm64_sequoia:     "275550329601b5ced5a16949f49afb1b7321b497afbde58fe864aef857e8f3c2"
    sha256 cellar: :any, arm64_linux:       "beb712f0998593d59cc24210c53dc8ecc97263ca5bb2bf280564d672bb61d83a"
    sha256 cellar: :any, x86_64_linux:      "6f09424e55c600239bacb8701b1ba7933e94c8221d29cd1c24bea800a3a06326"
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
