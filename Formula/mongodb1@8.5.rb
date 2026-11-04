# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "7291c9d8201f03a895a2a20fcd327787c0d78dba71ef237a694fe1241bcc447d"
    sha256 cellar: :any, arm64_tahoe:       "93169edbad849a58c0858871375bc7137b30c0834a5b2bbe351a629bf02a35f4"
    sha256 cellar: :any, arm64_sequoia:     "c95fd512720af41e58fa3d66ca0cd43002c589373d9330062fb990ec60cd1b7c"
    sha256 cellar: :any, arm64_linux:       "0dbe2807e58244adb471dc7b6a0ba478d09808b05b2a7a3b52c9805793cd8dea"
    sha256 cellar: :any, x86_64_linux:      "e33916bd023a597e700655d766879cc2b4e8e58cab37e01818e1e2171a1c1b6b"
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
    inreplace "src/contrib/php_array_api.h", "IS_INTERNED", "ZSTR_IS_INTERNED"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
