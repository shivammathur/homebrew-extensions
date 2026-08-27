# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "c47e0253f171af087daa9c718c2392afbe8c60300e928b46d411bbda5de8b556"
    sha256 cellar: :any, arm64_sequoia: "56b017d1addb0b81bb0c023c01befef3277ac6e91db87f8ce0432784c61c9843"
    sha256 cellar: :any, arm64_sonoma:  "12ec88c8f255cedcb71e5db23e1c32bd348806280ebddaa8bcf1439b81fd88f8"
    sha256 cellar: :any, sonoma:        "00df26bb4e92300f3c0188b7fb37e57bb1f809feb4f2557e81db3edaead6aec9"
    sha256 cellar: :any, arm64_linux:   "5675c78937ac37dfc919507174a8ce76c4d2634f0c57170b490b90a3bf379824"
    sha256 cellar: :any, x86_64_linux:  "78fc037f6996e29982e6ff6ada3bb13798fb9dd075496bafdc5b36fac51830d1"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
