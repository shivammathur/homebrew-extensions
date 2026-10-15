# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT87 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.5.tgz"
  sha256 "0eaf84ff709f73183d80597f31ff02937f6aefde01eb895a0aa19334a290cec0"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "8e37406c3aa7e51095a192cf7929ee6cb7fe6e792dd31931d0c40a3c11c23dbb"
    sha256 cellar: :any, arm64_tahoe:       "4276d975c546ca0866ae88fc3c2639c7f3261cf7e25a4308546a6f174015b378"
    sha256 cellar: :any, arm64_sequoia:     "bd94e2ba570adb6c1da82c86b0c0462fbcc51d9f18f63c34aafe7aa8c9f21203"
    sha256 cellar: :any, arm64_linux:       "2ef81f2a70b4069bfafe469d23f7f3443ac45c5235dd18b82a9260d45dc09753"
    sha256 cellar: :any, x86_64_linux:      "6777ee31a93864f2412dbd272d940581d9dea5f5753acb712a7b78f6ad6f6b9b"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    Dir.chdir "mongodb-#{version}"
    server_api = "src/MongoDB/ServerApi.c"
    if File.read(server_api).include?("ZVAL_IS_NULL") || File.read(server_api).include?("zval_is_true")
      inreplace server_api do |s|
        s.gsub! "ZVAL_IS_NULL", "Z_ISNULL_P" if File.read(server_api).include?("ZVAL_IS_NULL")
        s.gsub! "zval_is_true", "zend_is_true" if File.read(server_api).include?("zval_is_true")
      end
    end
    if File.read("src/MongoDB/Cursor.c").include?("zval_dtor")
      inreplace "src/MongoDB/Cursor.c", "zval_dtor", "zval_ptr_dtor_nogc"
    end
    unserializable = "src/BSON/Unserializable.c"
    zend_header = Utils::Path.formula_opt_include(php_formula) / "php/Zend/zend.h"
    # PHP 8.7 changed this callback to void; older development snapshots still use int.
    if File.read(zend_header).match?(/void\s+\(\*interface_gets_implemented\)/) &&
       File.read(unserializable).include?("static int phongo_implement_unserializable")
      inreplace unserializable do |s|
        s.gsub! "static int phongo_implement_unserializable", "static void phongo_implement_unserializable"
        s.gsub! "return FAILURE;", "return;"
        s.gsub! "return SUCCESS;", "return;"
      end
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
