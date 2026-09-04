# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "c5732cce7e19c3e045eaf83de68b6252aa0656a561678840a9d083fce892fee0"
    sha256 cellar: :any, arm64_sequoia: "5b8cba83b0205166b9289f4c9e238e8c67628e57e32d6a326f8b7e27e25145bb"
    sha256 cellar: :any, arm64_sonoma:  "16b6c72ba1868dd30f3b26c18e42a480702f6582a193be617993db7ab42b283a"
    sha256 cellar: :any, arm64_linux:   "06d2c02f82252735c640bd50fa40992ee42ec2f3ae33da32b652d31056b0e1ce"
    sha256 cellar: :any, x86_64_linux:  "9393d9aa6ce76c4c801a58fcb30a8ba2cb393889753a04008f44920dc7d73f1e"
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
