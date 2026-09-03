# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.8.tgz"
  sha256 "41f230589370ffa60a23e3443cec6493e556f8a7d74d42ab5d95fc65abe89856"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "8b246f0dbfe7a946e3adf79e1845d31245fa303e5a0b73613fb40abe3e43ba8b"
    sha256 cellar: :any, arm64_sequoia: "ce090394b0bae2973672283a570c3d6fdefb7272332a6c15283a0badf95cba3b"
    sha256 cellar: :any, arm64_sonoma:  "ad84f9951c4044fe6ac0f7a1132c6180f3a657609f1e68517f019d0051566841"
    sha256 cellar: :any, arm64_linux:   "8acbd3afad812c9753b164892d8330d0ef1b04c942b2bcdc4a1c5d9d7a3745d4"
    sha256 cellar: :any, x86_64_linux:  "ff0fc842277123cefb0000608417f70ddcca5ff1072418dcd0231e8bb50ac12e"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
