# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
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
    manifest_sha256 "be7c07071ba314c38a9242bf7ff25ea48b2fcfc2e39aa7c1aacc758f02cf0f7f"
    sha256 cellar: :any, arm64_golden_gate: "29ebf68b48f8598ee11b67a69ab561334cc3471567afffcb760d803ec69112b8"
    sha256 cellar: :any, arm64_tahoe:       "f0b4846d752fca34e320b14de195ebbc1e4466070dbcb136dd33bdb7830951e3"
    sha256 cellar: :any, arm64_sequoia:     "d1fedbe3abd87b1fc943c3c2eaf073d89ff8dd3e3bd2e1b9410364af342b9e61"
    sha256 cellar: :any, arm64_linux:       "2265a6b8370ae7751b0887b622c97dacad155af7e20a04de70cc575be340c58d"
    sha256 cellar: :any, x86_64_linux:      "fa0ba0a842e72e1b62e2123fd0cfe9af5699011a38d3e88bb6223c11a6340a5f"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
