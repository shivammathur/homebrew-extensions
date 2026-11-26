# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT87 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.9.tgz"
  sha256 "9ecf4f6005e1adbb0e5c59c55ff2e9c8347983060aac472043ee3b8570e816f3"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "357185f2f866ef9fe12dfc4494a56622f7113c82351933a28480266e1e410e97"
    sha256 cellar: :any, arm64_golden_gate: "1663c02e6a75888b07cc7229dacd72dd99c3c460dd5d65bb2b45d887c807ea26"
    sha256 cellar: :any, arm64_tahoe:       "b80a29bd7312e38086b729aa02cb88157a83545db8b8e6b6d2ef15fc54835706"
    sha256 cellar: :any, arm64_sequoia:     "fc217f9f3a9512745e0398b05778752ab3c7aa2fc5198aa9922a575f010ffc82"
    sha256 cellar: :any, arm64_linux:       "28978dcfe2eb63963b64f58e4a636a7edebd075c1c82a0f9ace1f28e3925113f"
    sha256 cellar: :any, x86_64_linux:      "eb14780e8626c32c98315ea351b817d0df4048655f20622e4c4a1d07bb9b4e18"
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
