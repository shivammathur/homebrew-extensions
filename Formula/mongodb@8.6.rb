# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.0.tgz"
  sha256 "7e7c4fbdc991bad24524316096d4ac9cd805632c9ba7f9886682db843d60166c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "942b5186917e9d97f8ccb76084637d12df6e5bec946eb465ae0bb32f34340e81"
    sha256 cellar: :any,                 arm64_sequoia: "66487bf30fb7bd306adc787f452bcab96159ac5a7590a6f1ece92a5f20a999e2"
    sha256 cellar: :any,                 arm64_sonoma:  "ab4434d9229de38ed480274f06e24fe599792d3a9a66939b77363afd542b5312"
    sha256 cellar: :any,                 sonoma:        "ce0c4317ad1e1d32af4958f9109c13a13ca2400702dcc016d616e82b51bd07bd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5bd7eedb5850edfb49338fa63c49418b41218d0598ea655a420a0a95aeee361b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f0815c647b9442a0b3d0b5d26e731a0f12e5873652240d0b21d0c1ef8aeca5e9"
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
