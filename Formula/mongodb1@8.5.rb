# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.2.tgz"
  sha256 "68547dcfb05d424c5bcb82d20fa4c41a5672aacf9953e6f301c89a4830f78db2"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "b592fdeec274a86b72df55efaede91e3bdcdd049a010d8dd6115d7974aeedcd4"
    sha256 cellar: :any,                 arm64_sequoia: "9e2eae01de72a7145179e0f0e0a07b0f0fe4fe918fa241e250721f585e0e81ae"
    sha256 cellar: :any,                 arm64_sonoma:  "8b6136f9576db4894cff616681218bc592ca285e0ed3878dc928cce810d9958f"
    sha256 cellar: :any,                 sonoma:        "276fc0049e2fd293e7b068b821eafc5a643cb12ee67a00fd29e93da020941ba8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "872602e4f06526742ef7cac15693dcde408c550a9bad7476bf46183d739a979d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3c1507e0b09778aa6e5b4918c8ab77984e811e6512d310e88382651d51236c30"
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
    inreplace "src/contrib/php_array_api.h", "IS_INTERNED", "ZSTR_IS_INTERNED"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
