# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "463fb9d903a283e934b785929b412cc1d0093051c46a9d82e13595ed9637e6fe"
    sha256 cellar: :any,                 arm64_sonoma:  "4167fe85aeb26ffe30b901fad0e50d51c32513a7403f7ab94856be1de4d32d45"
    sha256 cellar: :any,                 arm64_ventura: "cc326c5c5babbccb0af6eb6af50a9111fda970ac4354f1df4ae1da6457d3d3b7"
    sha256 cellar: :any,                 ventura:       "7b1a5939da9227a81d957e981e52927760e5581fc5d75fb480e4ebf7f814a063"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f780d95f6fe1f1830334bb33bc6a7c142452fd9abf5941c45cf9fc24657b7620"
  end

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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
