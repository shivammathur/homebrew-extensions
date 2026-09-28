# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT87 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.3.tgz"
  sha256 "5e5369cd01b47543fb3244917eff17fa4c8c357b0866828d59c899b4e53e6665"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "abd4fadb65ab9794ecc29d64e921f78f7a20299fa849b058e70b5bb509a50099"
    sha256 cellar: :any, arm64_tahoe:       "1fe8769ece838a2e217bcf199101ed88d48734dbbed1f5e29a05b75d4d1d09fe"
    sha256 cellar: :any, arm64_sequoia:     "fc26bec8bd9df147f6e140e23a55ccea5953fbbcef619c69c372d8e936be2fd6"
    sha256 cellar: :any, arm64_linux:       "22f9f3836a3a542080f6435a3348b8fafd7d0b61f0ab3da6c267f0ccd29c673a"
    sha256 cellar: :any, x86_64_linux:      "1a2fd4f1a17d211044f19bfffcb8299d02a3d237774e9977563fbcd691f030d2"
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
