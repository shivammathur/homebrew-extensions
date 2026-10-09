# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.11.tgz"
  sha256 "699671d3a36294851f9eb87a662dec226722f7375907727690d3e63bda6aa56c"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "80a8e2c1792507a6f4baf921e55fdf136879e8a1f2abe199c70e8135fe3879dd"
    sha256 cellar: :any, arm64_tahoe:       "088a96ea559670254f513371c094fc7260b58a3eaffa65550d1c677a97815080"
    sha256 cellar: :any, arm64_sequoia:     "0605289179a0047c1e81346fa859c567c689be68f1ccc536702087ea35e98544"
    sha256 cellar: :any, arm64_linux:       "e4f9248b1b75b177f7e3c92b68a8fe0eec2140208aeb462730a9bf959438666a"
    sha256 cellar: :any, x86_64_linux:      "364341f54703e53d455b57a671bae83a6443a689c7681a076e4e56065be76d70"
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
