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
    sha256 cellar: :any,                 arm64_tahoe:   "7c590c107b24127b8d99288ec2c956a68c3e0be4b3c14cb87fa409c218ebd8f7"
    sha256 cellar: :any,                 arm64_sequoia: "80135cc15d906fbdda64a22d9d929f1fa78b3c812b6ab9b376e9888ae6b9374c"
    sha256 cellar: :any,                 arm64_sonoma:  "4cd2ddb20f8f1fcc0faa9baf710dd95769b0e2d6c2c1d122ff7d62a5d849c2ec"
    sha256 cellar: :any,                 sonoma:        "ab40256d97f92a2d1e7e3cf8a4704fd8d3a2cddbd26026ceb0a9da187e28d753"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "26c12f87bfc066ed4395e41efcfc36de3aeb184fdd59574e179c2710ff2b6ab1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a668f61379baf88c484373923c7bc972d059ce360e911a5aaf803d1cbdfd2a1d"
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
