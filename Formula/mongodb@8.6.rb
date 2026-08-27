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
    sha256 cellar: :any, arm64_tahoe:   "1c926f1ba002b46b15a4c7072957e71481a5e72fe7396004a41f0cf27ce01fcc"
    sha256 cellar: :any, arm64_sequoia: "e5563c751f9bb0ea49316a2b04ca7b314dc1244e476d31e305ad09a4d9625a82"
    sha256 cellar: :any, arm64_sonoma:  "22fbd4fadc74c4691870dfb305d93861b3020d9b9b1161a5ff4b4a5b7dd25ed6"
    sha256 cellar: :any, sonoma:        "6b484625f11bd219166d466593840aa6dfc1bed8dafaff1d93c8c249ef9316ba"
    sha256 cellar: :any, arm64_linux:   "e79aeb0ad502e580952a0fa7ab562d0f28fc79aa3adf82817aca63b935d9e7a9"
    sha256 cellar: :any, x86_64_linux:  "45d9d70c9f0e385dfaaaf2e4d239a5f86d5d36235d7646b9e3ee7af4332c2646"
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
