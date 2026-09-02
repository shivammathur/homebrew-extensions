# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.0.tgz"
  sha256 "532b8408978a3b7a0aa4abdd7b33699ccbf94c312e7fce38da408b787006c08f"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "e4d9cdf2e2f6b6970ec17c044d3772e6fbc1aa6836b448692d9349ca432ac23b"
    sha256 cellar: :any, arm64_sequoia: "f98eeb8f48116b215b340cd8e73611f96965940b46f447bebbf5ed93ada3d4d0"
    sha256 cellar: :any, arm64_sonoma:  "d6acd4b2e120345e719c0c0a54cda7c1d26a8733c66a0ad822fc9199d23042e7"
    sha256 cellar: :any, arm64_linux:   "b8a340e889a58d82b45e78afb3fb4813e86d02c002075c9bea4226bf623ae8bd"
    sha256 cellar: :any, x86_64_linux:  "a6d1a1eb8cbdf620ddacc2e229504fb9c565cdd540e575c1889beac669ba480c"
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
