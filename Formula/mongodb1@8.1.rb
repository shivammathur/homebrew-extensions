# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.2.tgz"
  sha256 "68547dcfb05d424c5bcb82d20fa4c41a5672aacf9953e6f301c89a4830f78db2"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "aaee181eec6b86a20bc563a2e17d8c616df1b5bb905687d76445be19757bc222"
    sha256 cellar: :any,                 arm64_sequoia: "d8a8d7c27ef6d6353595a100a5fd6413862ef40164bdb0986272a4343bead43f"
    sha256 cellar: :any,                 arm64_sonoma:  "eab659cfda85dce463f84c6c54385bf8e841de3f68e85d9ed04bc7beb1245abe"
    sha256 cellar: :any,                 sonoma:        "6027718957032d975a2c27c35f3df50e6bf8d30ff4684620e9e91ba16fe49fd4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "316a5cc1aa1fa66bb09b7ea2d0333e0d66edcd3d94d75a41834cebd3d0b32f2e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "15801e9e8531375e3431442b5e8e1d0f8c1ab561dc0017a2ad1812f0bb2704b7"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@77"
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
