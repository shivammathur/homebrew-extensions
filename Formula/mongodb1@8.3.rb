# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.5.tgz"
  sha256 "b542e9285308dcd16ad4277f62a94cca2910ee57616a5a4f576ff686f3da4c77"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "dee57a442bca45727447fdda3d89c3fdbba95e7b57bf92f9fe70ab8b89859a9c"
    sha256 cellar: :any,                 arm64_sequoia: "8cac54894f33fb423d9bcbc528620ebc34177fbb9f6cb8ff35518dd36873e9c4"
    sha256 cellar: :any,                 arm64_sonoma:  "fabf2bbf830f423e2cb8f37fe532afd6d74b41809e442ff53223658c643b954e"
    sha256 cellar: :any,                 sonoma:        "e6dca5ecb8007cb2a7be9dd18325af1281fe06cc60b0c61f2f3ff735baa9c556"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5a8ba479eb50df87d8ad673e233484c7032d4ef110798b7436442653b4296a39"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "df10b8f388a472f6be8039efb767d7c88329b7c66ba848a8b3fe5033f5cd9eb4"
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
