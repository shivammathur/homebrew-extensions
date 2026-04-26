# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.2.1.tgz"
  sha256 "b923617bec3cde420d80bf78aeb05002be3c0e930b93adaacaa5c2e0c25adb42"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "186a6d952b3850e15c69663d88e802ccd5aa942ec7458276e6d86bb9e7f8e55d"
    sha256 cellar: :any,                 arm64_sequoia: "6e34bd49a63880ca48ca6f004794bb850725f9739ebc00ed68811e1dfbff34c2"
    sha256 cellar: :any,                 arm64_sonoma:  "0218d7d91b0a420b27ec9090a639dd8fdbe324858279e65667fbd62b604b303c"
    sha256 cellar: :any,                 sonoma:        "b1f5431c54a3c6e27150c2e5fc1d16697f328f2e9f9b98ddfa32692a0eeb66a7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "36e9915e1324aaf965eda0f08cb8a0dea81e3c1d1633b9b2f4ab8218eb078aff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9cffd2a8de090cc3bf869515bc35a7f4cffc8def6e9041ccb5bb0fde22e10d2e"
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
