# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "2915c9b8e8f6294c34b2a1d90a14a6fd51f0da7c1940925cc17dffce87163a8b"
    sha256 cellar: :any, arm64_tahoe:       "e24917f7aa30132a608480d95984a0c683bac7bd8540379c7b28db734b53819c"
    sha256 cellar: :any, arm64_sequoia:     "4c57eae4b868946578a68c514f8aaa038a096bb82b2a821756fd7aca68097579"
    sha256 cellar: :any, arm64_linux:       "8d8d3b5362985bb8e5cb986c837ca3cba77a458649a63e7001bd5a914a20b508"
    sha256 cellar: :any, x86_64_linux:      "21dd0fc3803e2e478ae0d5ff37190050e2a76edec2d7f344b42fd0ff12f0454a"
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
