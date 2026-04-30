# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.1.tgz"
  sha256 "2738972432d36c370fde3c76c208c31bd5a7a0afc4a7705874f92f322f3d2786"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "c94c1248db59e4901a109465f5b3196df270451be5d00e350f81b2b96eecbf1e"
    sha256 cellar: :any,                 arm64_sequoia: "86f60855c15910b3309ffb8bf8d5cb47f7a7957f72eb01d5ec66ae21ced1029e"
    sha256 cellar: :any,                 arm64_sonoma:  "405669d1863a9d34df1187b2bd7f4f0472db4d661a09fcf992cb0173aa2bbdfb"
    sha256 cellar: :any,                 sonoma:        "70a5563c928459fb127307d457baf2c264df14f2c756786e54e9ebca38360321"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "45d6fd2d6bb5ec93cbb1acda6f9c9107172c6eac53bbbf132b1e73a42b27321a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f8e60a4d51ce2a6a0cf71246d63138f35e71487d57c24426b81cd651d4675c40"
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
    inreplace %w[
      src/BSON/Binary.c
      src/BSON/DBPointer.c
      src/BSON/Decimal128.c
      src/BSON/Document.c
      src/BSON/Int64.c
      src/BSON/Iterator.c
      src/BSON/Javascript.c
      src/BSON/ObjectId.c
      src/BSON/PackedArray.c
      src/BSON/Regex.c
      src/BSON/Symbol.c
      src/BSON/Timestamp.c
      src/BSON/UTCDateTime.c
      src/BSON/Undefined.c
      src/MongoDB/BulkWrite.c
      src/MongoDB/BulkWriteCommand.c
      src/MongoDB/BulkWriteCommandResult.c
      src/MongoDB/ClientEncryption.c
      src/MongoDB/Command.c
      src/MongoDB/Cursor.c
      src/MongoDB/Manager.c
      src/MongoDB/Monitoring/ServerChangedEvent.c
      src/MongoDB/Monitoring/TopologyChangedEvent.c
      src/MongoDB/Query.c
      src/MongoDB/ReadConcern.c
      src/MongoDB/ReadPreference.c
      src/MongoDB/Server.c
      src/MongoDB/ServerApi.c
      src/MongoDB/ServerDescription.c
      src/MongoDB/Session.c
      src/MongoDB/TopologyDescription.c
      src/MongoDB/WriteConcern.c
      src/MongoDB/WriteResult.c
      src/phongo_classes.h
    ], "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
