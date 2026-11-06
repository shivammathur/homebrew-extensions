# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT87 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.7.tgz"
  sha256 "078773856f4066b56738fc13950bb7ee16b5e66f727fb41d3fbec6043c78fd32"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "18d689b45267fe9c67e6d0cd0bc3bfdbacefbb6e5a1e076720fec7907c45ef27"
    sha256 cellar: :any, arm64_tahoe:       "0707607d3b43677ecad8362b902d76d124c28d60f2cb0b7248630429c256ad65"
    sha256 cellar: :any, arm64_sequoia:     "aa8dc8cf6357f91adc8c30861eebf350e908df451d51490b4a4ec1c99f219c73"
    sha256 cellar: :any, arm64_linux:       "4975235339e39081330ee92cfc03e776893b444eca47ae074b7a71865119712d"
    sha256 cellar: :any, x86_64_linux:      "3cc42caf855c967e490b955a60107c93f2281f373b102d8a5f80820e27b7abdf"
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
