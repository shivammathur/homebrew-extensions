# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.2.1.tgz"
  sha256 "b923617bec3cde420d80bf78aeb05002be3c0e930b93adaacaa5c2e0c25adb42"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e8ece800b3c174f9eda5ec0c14deb7f16676e2386d2ea89df7c0c1d2e6cb2755"
    sha256 cellar: :any,                 arm64_sequoia: "34574bd00171fd799696cf45833a57ddf0515c15e6dfdf77905b8f9bf28a732e"
    sha256 cellar: :any,                 arm64_sonoma:  "b3de7e5ef2f7a0a5f3b852fa3484c0c33008414f31e4e3e64ff1934cd869db02"
    sha256 cellar: :any,                 sonoma:        "c6cefd6baa16c5c5c5012f0c8f54cfbe39e572c8cfa566351cd05516e0979262"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "01d9dd99b6ef86cb4b058838638b2eb3bc6d3afc0197b3bdbecaa5a364715e9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "00a44fef4d2d7dc62e66be07f31a26ec2f95070e988312c1ae57f4a63fb2de54"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
