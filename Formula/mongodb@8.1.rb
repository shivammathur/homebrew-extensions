# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.3.tgz"
  sha256 "5e5369cd01b47543fb3244917eff17fa4c8c357b0866828d59c899b4e53e6665"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "fc66fd2fba8bd83ea9985a0d5e9ba0a28b5456c6326b1216e1c1a612fd49be9c"
    sha256 cellar: :any, arm64_tahoe:       "f6753f413c4a1a7373b93b14dd2293e372c83879895591d31bca8f7282147692"
    sha256 cellar: :any, arm64_sequoia:     "a062c0f0840359f1e2a30e38b5d773b585ff78d5889c6e484e42a14c8cf4986f"
    sha256 cellar: :any, arm64_linux:       "60986347e36e5fe84d6eae88908a296a1bb6eebb737917f504dc036e9965ab53"
    sha256 cellar: :any, x86_64_linux:      "722ee1e4e435b6b8b942d6bf8231dd70fffd69d79c96ef751492e6ed8f839461"
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
