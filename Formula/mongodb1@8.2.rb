# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "0b6a065ae52ae89379430cb9249bf877bde0eb2bbc0b05f27316e67d5fb78d83"
    sha256 cellar: :any, arm64_tahoe:       "9c3d005974101ee003e27b095de1c6f4b6b61713eb5b8b1867784e180446deb7"
    sha256 cellar: :any, arm64_sequoia:     "20c3cfd41f1219bd39a88aa9d10d5b43dc482cc0614354bf6ee3eb572ed5e42a"
    sha256 cellar: :any, arm64_linux:       "5ba6fe7451e849ed6ff4e9fda626ccfcfc7e44fba1c47dae1f9e57c2ef5bd775"
    sha256 cellar: :any, x86_64_linux:      "83c471a64b2234c248a1d0bbfbe90cdf2635312f3c6241da5c02464db3f811f3"
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
