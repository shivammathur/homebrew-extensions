# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "d488a77f02995b21922dec4eb5825bed5996b52fe1cf2cab388869d13c7e875f"
    sha256 cellar: :any,                 arm64_sequoia: "54dd10b27f7f284d9b6c0888a015094aafbd7e5a8252257617a9ca1f9d36b94c"
    sha256 cellar: :any,                 arm64_sonoma:  "9eadcc7ad55842f31bc2f477ac9ed58f35f8e649b94ddb132caa8067a0938b49"
    sha256 cellar: :any,                 sonoma:        "10068fd1e5a0b4f2b9701dea093c3939cb92405c0bf6d64851682900ffb49854"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9a79ce5c21b5d06743f898d0494d140d991b2f6ff45a07accae734df955e6ba2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a95b0e6c1627046d0d9ee4a8450c9929f6cc30f5b5a5d63f5e610f5f7d700eb1"
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
