# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.7.tgz"
  sha256 "e4e30d82639d698a174356193f7ff33b101523d16ae769faf66fbb217dfb36c4"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "c111dee4b35a63c6a03d531f52971cf5b863e4ec75f1d4edfe13d27a036aa18d"
    sha256 cellar: :any, arm64_sequoia: "dc9f39f7e39a85880793b04e28bbbe204032a46ffb34d3266791504ee714efb7"
    sha256 cellar: :any, arm64_sonoma:  "da408c508146f3000cc0d6c94aabdd44fdd86838067bc0ea7017ad12f48ef13b"
    sha256 cellar: :any, sonoma:        "044ce40138bcd42fdbe438ea3c9a8c08df2d8c2646f8a8f8162c2fa7b717c03d"
    sha256 cellar: :any, arm64_linux:   "22ceea117e2086c4de856f60f7d830dc75858e786efacffe82de2e8525c16341"
    sha256 cellar: :any, x86_64_linux:  "b85da27bf0edd73c59b04d1bd3a6b4ab755f11f1b77e0084e8d39a989fe78991"
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
    inreplace "src/contrib/php_array_api.h", "IS_INTERNED", "ZSTR_IS_INTERNED"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
