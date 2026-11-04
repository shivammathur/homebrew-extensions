# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.13.tgz"
  sha256 "317d6ec24e8eefa741405002cbf788b8549ad302c630c0c7b08dd445940da5c6"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "a41c0729f2c5f47e490fa54c71cb1108a4033adfdd2de3c1ca0ed8d3250a6b31"
    sha256 cellar: :any, arm64_tahoe:       "cb4ba3635f0c37d94814c160699cc7cd8a173926170b88e45a28aa5000d555dd"
    sha256 cellar: :any, arm64_sequoia:     "b9fd00d295ccc49d325dc5055051d8206dbe0b6086a2d262b34a2ac51b0142f4"
    sha256 cellar: :any, arm64_linux:       "53c776a48bf1bab17c7321a44ad8526facac6bd2c92a0fbcc973ec83a47a955c"
    sha256 cellar: :any, x86_64_linux:      "f6816c53612692e80fe090be4c758c55d65ef0a947c19e3e80e8818fc1fe1510"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
