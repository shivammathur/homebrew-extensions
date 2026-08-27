# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.4.1.tgz"
  sha256 "a57dc6bd18938ac2396086d9eec44bc82e7d17c399844923b04fe4cdff895ac0"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "41c0388e04ba90e795cc404562e69155e943f2c7596a9ef49696da0f0f84fcfc"
    sha256 cellar: :any, arm64_sequoia: "a43efec74974daa403b6f2d32c53f81f811b291087c70e9fffcde34f8ee2e4e4"
    sha256 cellar: :any, arm64_sonoma:  "2daebd452094352e6f3289c1e863e94caa3abed59650a72102b0e30b2985528c"
    sha256 cellar: :any, sonoma:        "b87e2fb2b64ab0aab956dbf184427423d41a3ff53dd5a7b9a9a484ec389b573c"
    sha256 cellar: :any, arm64_linux:   "d51d8ea72c4d88352afa1714a3a0a0f246fe1a0de61a789782ce7cb831d41b70"
    sha256 cellar: :any, x86_64_linux:  "7dce85325354baf39cbb52657d006075a605c1dcb4edbb5feeb5be51e40a4447"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
