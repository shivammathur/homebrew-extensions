# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "6a69082d279bf889df4d14a064b0017da7da44bf5c99300ec3467e8f7bdc8244"
    sha256 cellar: :any,                 arm64_sequoia: "c914d86996d2754649a911a804605fca9f4dab22d282a8eb0931aa431ae44eda"
    sha256 cellar: :any,                 arm64_sonoma:  "0c96e14b8f6be3a11fe763a1b699e56aaeb37b0b4d7e2cc3b4fdcd32808982e7"
    sha256 cellar: :any,                 sonoma:        "e35dc0e9d8ff5ddd11d4a310d09e8e073f899798c2f0e5fda69a74233f6475ae"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0ef5f284c2723e5538ffb82fc9dfeeeddb9688697db8e7990bc3b6f18a17b043"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a024fe3f9f198ccf44112f98c8b8c9950771b4b7f03c9501111ff7ba5e9cd8cc"
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
    inreplace "src/MongoDB/ServerApi.c", "ZVAL_IS_NULL", "Z_ISNULL_P"
    inreplace "src/MongoDB/ServerApi.c", "zval_is_true", "zend_is_true"
    inreplace "src/MongoDB/Cursor.c", "zval_dtor", "zval_ptr_dtor_nogc"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
