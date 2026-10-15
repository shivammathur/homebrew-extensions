# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "7786886993ead7bd34f02aac06b75694d5ea49e7966665e526999f5635e8d969"
    sha256 cellar: :any, arm64_tahoe:       "a83000370af427dfb27c87af2fd8867b56c77d212b0ea8870819ffbac76f310e"
    sha256 cellar: :any, arm64_sequoia:     "e1605c9b56f1ce254184d2de5f77eae601e1234bd1330680af5a4f01702c5ddb"
    sha256 cellar: :any, arm64_linux:       "0c93572bb0faccfcafa4bd4b530ee800edeb6d64291619bcac37fac58a54607e"
    sha256 cellar: :any, x86_64_linux:      "7d35d2e7ae3de8d463c51b0993c52704acf790bd89e076f335d5c2ce1e3c7452"
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
