# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.2.0.tgz"
  sha256 "02b0fc089176a1cc2133b5e12aba72bff103154d2ead4789749a99c1b47f8223"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "6fb75426e6a4a46d7cc9d304cef81ec6a1a56578330e015986cc88f94d04b5c7"
    sha256 cellar: :any,                 arm64_sequoia: "d4cfb739b5ff5e8b3158ef92641829c11696144419262a4f874f6f9a82b2bca3"
    sha256 cellar: :any,                 arm64_sonoma:  "710a33f0c40434a787784a381571874a18419a1f2c03ef881a80d82fbf32809c"
    sha256 cellar: :any,                 sonoma:        "4ba53021b047335c217e0500452b968beff9aa81119e253daafbf11617bb237b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9d548fdd429cb42b26caad6e0048b56ab61db1ee148bbc4b6c8dbebea8dbb092"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a2bc2e8ef730ed7012678cb746a37c0e2c7e9175d7a0320ae8e033c30d9cc72"
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
