# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT87 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.4.tgz"
  sha256 "41eead0799cc66876b12d10b5efe86268bfc704c1be57a70d49e4bd4bf6c8ee1"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "bf4d60abce9fe2322b1196ce945e7cd2a8a8cbb9c29dda8e8cbb611b251bffea"
    sha256 cellar: :any, arm64_tahoe:       "4474eaba163f994acbfd5df66a09b2f608204e0c8e931882b69159c75e0264cb"
    sha256 cellar: :any, arm64_sequoia:     "6db8457ef4ccbff9f23f8754d0448db4eeccf1aa2bd24857acf50644e0322f77"
    sha256 cellar: :any, arm64_linux:       "c8f6e18ca160141d7180f5b72a01ad5fe16f44e4dedb5851359e0b591885b83c"
    sha256 cellar: :any, x86_64_linux:      "f6831e78e219d767a71fdbdef29479f0cbd64782c940d2cc703fa77e1b47e7f5"
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
