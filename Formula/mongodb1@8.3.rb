# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "e39ade77e28c29b2455f9b966ea6829a0bb0dd9439a676a4b88c109ed54d5047"
    sha256 cellar: :any,                 arm64_sequoia: "c22faf4b4999dd63e1d10870c5aa7f917e7dc0ad1f95805482fa75a5e7158a77"
    sha256 cellar: :any,                 arm64_sonoma:  "f4b075103dec7cd80e12a328a00b2be5c7c6eedc418191877a1495f077f3cfd4"
    sha256 cellar: :any,                 sonoma:        "7b89fbe8ff6feaee34b256e1000a8c8b10a5d8dda18189d4861626d542bee8c7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3634fdc0ae7d73890ae058831f5c4245f91dfb89b7555bf9ae161d5ad4397f04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "608ef5b958e86e39057b35a7e565fcc79a779f4b8de42da543656f86d45c9abd"
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
