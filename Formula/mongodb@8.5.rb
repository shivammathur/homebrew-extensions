# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.7.tgz"
  sha256 "0f46e64139569839b2becd30662a09843ffa9e99b8c4d006b2648a031a10fcc9"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e14f585a5a035fc72f066f2173daf0fa17209dc64b444e1a11b3980e8d68c18d"
    sha256 cellar: :any,                 arm64_sequoia: "4c3f9336107bbd2446b8b0ebd019ec2551cda5c08b2fb492ac0e076dd8bd1204"
    sha256 cellar: :any,                 arm64_sonoma:  "481340944c3c0b3eeb6161f192bb71e130af17def62aa77deb08b7428cced86b"
    sha256 cellar: :any,                 sonoma:        "b4515d4288872e14c401cd7e2d70c2b63fbca10c07ce2a6d2d3edf3361058f32"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "130aca94c03aab6e838b8d9e12c9b4a4b0eff262a9c4d57576c12c39630a9cd2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1c4398a14e6463c29233f28fe56c891dbd9b77f80138a59ee834d21df8053c9d"
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
