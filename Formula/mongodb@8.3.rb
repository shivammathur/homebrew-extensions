# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "9a060c640a677ee61149c51111664f6f97bc7fe5f9ae4b5e4140c23926a4e804"
    sha256 cellar: :any,                 arm64_sequoia: "349cbe8daa7b013b705b666c9f49d675d4220d0aaacc43640d7709c02d1e46a9"
    sha256 cellar: :any,                 arm64_sonoma:  "7f73392ae1322411649beab507e427e5bd7cd219d2376a2b2122e456c42164cb"
    sha256 cellar: :any,                 sonoma:        "c93d4381685c07ef029ed1c40ded0f94b1b1af76be2b8693ec1c0120ba220361"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "03164902dee2eaa0fd970c5e8b7472d547926df7b13c9d197667c680eb41c87d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "67fc9a083ad4e5d2b7ebbd68ac379da3084589ee005f21d9d43c272d912de8df"
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
