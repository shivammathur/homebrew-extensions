# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.2.tgz"
  sha256 "84081b780d48af884d47f0339800c3666c664c66f0035c66d43a34a10fb67376"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "12c9f991d0e35fdb98c31f158d5ac7c718f9c447a8a33d0a98bbfd8c4ab27cbd"
    sha256 cellar: :any,                 arm64_ventura:  "74e0954a62d99c50756f5f893b456b273cf006031488fab30d57e7b825658d45"
    sha256 cellar: :any,                 arm64_monterey: "1edee31a037d653b8b5bb860ba7ea5a2706b57ea84d242a7fa7e83386c5df009"
    sha256 cellar: :any,                 ventura:        "c3d1b414e1e503e70cf8f12912e0acc7ede8016e21d1bce273b2262bb8d11f8d"
    sha256 cellar: :any,                 monterey:       "395b05aeb07a8444d3afb3b85105b3ed0735faccf6c98b68adf686edba63ae39"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cf5af970fbfe529ead111973997de46a3e68343127e2cb2b69364ea25f533a34"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
