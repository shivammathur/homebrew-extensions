# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "1e7675387647894307660c9edff301fc0f7ba05f22c1082b89ad75f2136f8687"
    sha256 cellar: :any,                 arm64_sequoia: "7a881b7acbe17e4904259e8c3c7d52b0c3bc109854046ebe88b01b4ea272b1d3"
    sha256 cellar: :any,                 arm64_sonoma:  "52278da02f650eda49628d20a2986345366e5a8d9e031caccd3563cdb396bb17"
    sha256 cellar: :any,                 sonoma:        "2e172868a306c51cecce511bf69459f96c6e03c9927f0cdafec1510665c613e3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c5066df5370a5a8a64bba78340516381f6940c46f4d7bf147c88b03792387501"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "181964dda545f377e7a0dedabf3490a233c008c51caffa7688f4f80e129b64f2"
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
