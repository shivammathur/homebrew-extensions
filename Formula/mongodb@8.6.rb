# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.4.tgz"
  sha256 "a5d09090fec30f1a8c26d0ea2f2b36583e1a2ca2b74754a3aad9753193a2a5e1"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "4ae9f2a9cd5b040af6153da1dadd58af57c89500530c9827c7faf24fa7ba25c3"
    sha256 cellar: :any,                 arm64_sequoia: "a6ea2529fe93247a0090ec75780ce026dc8457aecd94c962e34bc9d05ea961b3"
    sha256 cellar: :any,                 arm64_sonoma:  "46fa5b0c0401695af3639047246cc40060a98c133ce8c1d694bbacb1526b756b"
    sha256 cellar: :any,                 sonoma:        "12ada76003dcf799c2cb621c6ea47b8bb8e4b642eb10a1c8beb1c46a25a4bb65"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f356169deb55ac4961358de05c2bc6036279a7e40a3849107bdd3492ad8d5483"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "18cd930c7588f4698852c6be299a3a8e976b8ed122da632714653a2198274767"
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
    inreplace "src/MongoDB/ServerApi.c", "ZVAL_IS_NULL", "Z_ISNULL_P"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
