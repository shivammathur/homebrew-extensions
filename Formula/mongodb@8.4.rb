# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.4.tgz"
  sha256 "a5d09090fec30f1a8c26d0ea2f2b36583e1a2ca2b74754a3aad9753193a2a5e1"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "4c0b4b812c8a9bc8906b59a183f3ad91549a0cbb0fdd0608255439b32949f7a4"
    sha256 cellar: :any,                 arm64_sequoia: "9c764015aad1d642d1c769eae786ec327e9e9c5e5b8660d0b116fe078791c592"
    sha256 cellar: :any,                 arm64_sonoma:  "d396648dea29a69b77f04e2ba071ea28cf48ff4ec040c4dfccdf8053828bed3e"
    sha256 cellar: :any,                 sonoma:        "1a4ad9e19431e201a26bfb7e00137b11f8354bc1ff130eee8e3c4e9dba20e19c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5b05a5f1d3a88bf92ed8330b63e9b26556efc6cbac6027b6fb042a9d60096e40"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ccfa54fdf9a276f3f102cac1d2c7b99d566ab5833a98ef550b064699f8554976"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@77"
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
