# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.12.tgz"
  sha256 "d4d2a8ad034685eacd7ea3ed96c0c9aed8c0165ea6e79d106bdf95214d5eaa35"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "cdfe1337cc23fd1f05bd886fc58b5ca8627fbf8952b2a16c93db231c1923cf1e"
    sha256 cellar: :any, arm64_tahoe:       "0363b58b4629fe64515d2dd29690c99fda77dc7a3f2ac66eaeba0839f423d822"
    sha256 cellar: :any, arm64_sequoia:     "324e4e1f6ff42a9e741f48800f894a0911d1332ff014b7030feb81c4b2ee9b70"
    sha256 cellar: :any, arm64_linux:       "44ff31fc73be06ae20b8e70df9dd663d8a518b503d1c224be39702687b55b58e"
    sha256 cellar: :any, x86_64_linux:      "80ff679171e19a5a204b405e431df97b4260d573afb066563f11c048eefd1ab5"
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
