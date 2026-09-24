# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.10.tgz"
  sha256 "316a6027f2dd612771a4d7e36d6bc9e8e96c7825a611fcc8b7fc5f270ecf6705"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "64f3c2a1d1e788d70beae535bec50b70d8b54d18f05328d1df5568484e104d21"
    sha256 cellar: :any, arm64_tahoe:       "1ed35cdbcb7e9059ecb9072b136847250b78b3908c669e1dfc219ef35bd72d07"
    sha256 cellar: :any, arm64_sequoia:     "60491bcabe2b03d05d36c2939c33d22ae4b89b2e1a427a8e1ed7f87efba0f4c1"
    sha256 cellar: :any, arm64_linux:       "1efb4772be31279a7e22dbca944698b647787b25bc6a8fba1ee4b36b511d82e2"
    sha256 cellar: :any, x86_64_linux:      "837b4bba208697aa54b532c9b271c8b58571445ff60f7bad9f5161b270fdd89b"
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
