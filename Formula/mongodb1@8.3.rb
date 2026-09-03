# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.9.tgz"
  sha256 "05045ef555d042991c6991d4439b85ebcaee5698f3733516f656508131d6e6c3"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "d31185c09675c5dddb2c302c818365ae062a01134e939c33e3f79ea12993e054"
    sha256 cellar: :any, arm64_sequoia: "4043e19190a2ed4fb78ce3f580c31e842915aeb2c06fa6ea23185727b0a2a6a6"
    sha256 cellar: :any, arm64_sonoma:  "11f3dc360ab0cf35736ca5d9be8b68988e67fca98b9f6abf80c5fc2a64bc8092"
    sha256 cellar: :any, arm64_linux:   "a22ad7514cdec773d7b44d1bc35ced568e35faac519e8964ed33be84b6297579"
    sha256 cellar: :any, x86_64_linux:  "d84668c3fd24378940f5e2ff2aa335ae4b50a1200b9b09a3df72cb2a199629d5"
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
