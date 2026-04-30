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
    sha256 cellar: :any,                 arm64_tahoe:   "3b28ed09ee99715c1f2b1a43f2aefea02628c59690a62fbf489dc5bcf121e99e"
    sha256 cellar: :any,                 arm64_sequoia: "8415072688aa9a8a9fc5101366b8af09b911a28f90be89b5a2c3f13a5cbc8962"
    sha256 cellar: :any,                 arm64_sonoma:  "e5929fd7257f869eb7cd8422e4eeb308b6171b3ec0d7b04750a61d74ca3cb920"
    sha256 cellar: :any,                 sonoma:        "6e7c3d89f4304ae28ac70a2834e2e662989c1754cbf7b00ee275b5aee22db86f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7345735ddef413bb659973cc63246e355afa748668f351766366bba21a8d3c65"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fbf106c7ffb93897e33903e5e606865d3d5c0cff135811880610f066969405cc"
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
