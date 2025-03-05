# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "2780ad70800d3f9b8aa58931ed497699058aeb11375e4698fe0c596e7a979b6a"
    sha256 cellar: :any,                 arm64_sonoma:  "ce2726a00a43983f292a839afd8fcaa81ba86b11cf75ce37565c427226417da4"
    sha256 cellar: :any,                 arm64_ventura: "d814774d5768e26e35cdef6a5c69f0ca476f2534dfb4163580e879df707c5395"
    sha256 cellar: :any,                 ventura:       "486b6651c7fe2505f3ea235e1680e4b8748eddf10e39bfe53a189980e820af46"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bc5dcb2d3ae22c2eeef9092dda73db7aeade265bc9fe3ae008fdf596526c5219"
  end

  depends_on "icu4c@76"
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
