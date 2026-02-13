# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.2.1.tgz"
  sha256 "b923617bec3cde420d80bf78aeb05002be3c0e930b93adaacaa5c2e0c25adb42"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ef89bff4340d54a3e5586ada066e5a9dbaa870e739f5ffbca4a8b15c7500c949"
    sha256 cellar: :any,                 arm64_sequoia: "6c1f25b0f950bc50018d512e41bc875ce5328afd934e79c5540e426af2ceae6c"
    sha256 cellar: :any,                 arm64_sonoma:  "22e71c1751005c035c3d57bd000f61122aec5592aa2deccac21dc077982433e0"
    sha256 cellar: :any,                 sonoma:        "717e60c3b6d30f78c9ed08eaee9be987dcde54a54588a2405c8cc612a206767e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f81ef1af2c6124892ba7f26573b781ba0f0579d62472e0356df61cdf98a2dcaf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9e5020e51d5be6d606ab0b442388208df0e357d0a85e15a46b31d28339e2aaba"
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
