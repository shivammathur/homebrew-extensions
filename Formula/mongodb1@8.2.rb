# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "81736306daf7ea15c8842606b0553f22cb87c061ae893ffab5fae743b1441b0f"
    sha256 cellar: :any, arm64_sequoia: "b2c61f2de8e2db151dbacc45452195047a77805fcc4786dbe6dea18525d7af4e"
    sha256 cellar: :any, arm64_sonoma:  "aa8f84ebefb65aa909f4463178a1fff4e6fba0fa41452c47db1a55a12cc5d709"
    sha256 cellar: :any, arm64_linux:   "950ebde5b0d02793c3f1a666b1a4f42e8609568c129714ac95b6fd31e44560be"
    sha256 cellar: :any, x86_64_linux:  "f243ee4784bf5a5a4ad0be58e2e5467f9b037f9f6ec586254a88b513ce8d260f"
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
