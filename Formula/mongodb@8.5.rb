# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.8.tgz"
  sha256 "fd0d34b4c530bad6dc4e0be61e23c118a3cc851ad879e088d6afca25b574916b"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "f28d6a95ef9e10cc0a15d8a1bc5d28e96058bc05b632636d8ef720c9a17eea61"
    sha256 cellar: :any,                 arm64_sequoia: "63a297777933488c20c9776f300b58bb052156eb674ebb056604c924b56a53c7"
    sha256 cellar: :any,                 arm64_sonoma:  "dcc186995a4db16d239aa89917c3f4823044130576fb93ea1e86f04d056b2360"
    sha256 cellar: :any,                 sonoma:        "bf2ff219c8f0f311d6db387df15a22c53281cd2d7d67a29a1c2d2d0c32a668e4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "81fffdd8b916ca0f3a1c9e84729e9a6aef5ee18074833d65a32949f6a4d4bb0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "40f1965857b295f3c6f12297ed84064fd3e08ea8632af2cdca484b439770a17d"
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
