# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.3.tgz"
  sha256 "370ff9c06932139c69f6b4c57b1a97c95b0278d3baf23fa42b8fb571ddb92bbf"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "aa83ba865ba94890c1361bab8e3976b14cc51e34edd1c0d0ce180bbf06ac63e8"
    sha256 cellar: :any,                 arm64_sequoia: "81bc7df86671d863abecb241976a5bea438f60512610c0001b0181148da3b814"
    sha256 cellar: :any,                 arm64_sonoma:  "c380634cc1b4e2090e21a19310dfadf105007af465ebc3c4168755d7698edd4a"
    sha256 cellar: :any,                 sonoma:        "1d15eee49bd1ddea1a64b48212f6e011d8cd3e63f241f9856d561896ee1d1d38"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6dc7f19b20ef857d7b7e0adb7a449f9431aec4144419d6254ace3d00aac77228"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "71ff696278c040c1a29c904f01e62faa43113a383209fe0c2d7df5e8af81a289"
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
