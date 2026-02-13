# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.2.1.tgz"
  sha256 "b923617bec3cde420d80bf78aeb05002be3c0e930b93adaacaa5c2e0c25adb42"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "0ab06221ce2c35a6bdbc6a1f035e0a9e9c06c41d26a361b994536cc20cda9649"
    sha256 cellar: :any,                 arm64_sequoia: "18e37fb9ba11a2cc5884c4fc7d7ade884fa5ab9d32723555db3ec9857ce1adfb"
    sha256 cellar: :any,                 arm64_sonoma:  "61b0a3dedeca47d0fc03259705960ec0806e5e8c5b1c3aa3d3cb331ad8e5a760"
    sha256 cellar: :any,                 sonoma:        "e72c339792f25606cd81985d48b3602ca52b7c9d0d38de63c74b15758eb1c30e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "643e1ea709cc01e48fc63e0a09f8ee447b7d9c40cacf9279740b6e25d6407b96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a2ab3a37292c33c3de7cfb07ef3d8811798c76990d39559b395a0a638a02b51b"
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
