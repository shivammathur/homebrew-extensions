# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "707241857c70827ea1d301029e6169a6a4f73c758c62b38270dc7a83a6dfe3ab"
    sha256 cellar: :any, arm64_tahoe:       "eece6ac0408b5a2724e537ff464d046d8ef7e7179c9eada2b9a8a9fd98707751"
    sha256 cellar: :any, arm64_sequoia:     "b774b59a546b7b795f6ec1fb7c35f615e219f52cb3f34637905ad75638929206"
    sha256 cellar: :any, arm64_linux:       "05c1df2ab57538965926e19d1e9b4ce6ba545f5731a563b39288b4d8e9f76868"
    sha256 cellar: :any, x86_64_linux:      "3098658b2cc7e009af0d2ca9d71b54b5a9ea1028c153a9c58048f47658465ffb"
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
