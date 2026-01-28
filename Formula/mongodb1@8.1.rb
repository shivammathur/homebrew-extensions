# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.4.tgz"
  sha256 "ad299dfc4f69859acdb82d7eca5140833370dce31ebbe2c628e716ed3167b841"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "0c10d2b6de81a6ffd006c2f7146228ecd6454592109c2423348e621745c55dd2"
    sha256 cellar: :any,                 arm64_sequoia: "9e327150ead7fffb5c6994406ba75f9e4d771dec21faa1ba99e9b6a3b4e6f30f"
    sha256 cellar: :any,                 arm64_sonoma:  "3ecd97eeed9f4c48c338b81fd8ab7df013735dccceed3faef6ec57bcbde18e13"
    sha256 cellar: :any,                 sonoma:        "3fe69628c762daabd4ee3e4f441dc2c3d81461b5274b3d881dac57aa39dd2ffc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bb4d41e7dff613ab19879a14a09e0baaa2c253a1d338617ef06128b228ba92cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c88b883cb2319a441d0c6075f854552cea57646d14f7d383dba04208d34f58af"
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
