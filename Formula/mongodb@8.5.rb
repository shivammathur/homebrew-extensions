# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "43241d3f9d33ae559634426d57300f71a27cd67447804ed1f4a6d48efd1c1a65"
    sha256 cellar: :any,                 arm64_sequoia: "61089f095ea7a3d25faadc0a6af6801b19923787b993b799927a1cf3b153a44b"
    sha256 cellar: :any,                 arm64_sonoma:  "3bc30192cfc8ff23504494fa895eda27a7125218366d486c4175f83dfd7b0269"
    sha256 cellar: :any,                 sonoma:        "6f43f1950db9701bc1e2aec64c1b8478713f63a68f073337994069644a3ac60c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0192659f5ca1f9884970cc490aac7a43f0d0a471f84cbf2da19313600c472182"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d372cd30064b1ffde642915165bd5f998e97c9376a345b0a4c08d87976c5b032"
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
