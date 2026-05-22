# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.3.tgz"
  sha256 "370ff9c06932139c69f6b4c57b1a97c95b0278d3baf23fa42b8fb571ddb92bbf"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "3442b96c75c9db3bc5d25b3f06f77015aa8e42de4d16be668097d1b6b607ec01"
    sha256 cellar: :any,                 arm64_sequoia: "c9124ae57c17be4c82a6d7fd0c36ef310703ff6f8eda330c06ceab8999449e2b"
    sha256 cellar: :any,                 arm64_sonoma:  "e4bf4ad3679c0aac8c0ace91ff77e7cd79a2fe5e174b25b92ec244495e97797a"
    sha256 cellar: :any,                 sonoma:        "f78ed0ae413ef2a4f37da36a57e66b300838ac3ebb99cfdabb0df070ea09c79b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9b55e5bc088239fa3cf82ba18b6d6075c57a950faf53eace553b04fd95621adb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d23456c3e51a4137e2ab8b778ee14cdc2c3b1a2b3822c7ec065a20cc65cd0b95"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
