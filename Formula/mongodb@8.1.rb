# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.2.tgz"
  sha256 "df01e7c41166fd068558977e390623061b3ef626e056b0fb4edb4d816021569c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "4a050ae98b4a77ba8b125343ecb8b2047412f0d3fa52aa92d2a580ab5aed83e5"
    sha256 cellar: :any,                 arm64_sequoia: "99420f94e53043d0d61f165025fe43ed8b9c30277a3d9097365a846817676ac4"
    sha256 cellar: :any,                 arm64_sonoma:  "4b30f6ae72242bcf86f67d2a5b840fcf446ecb2a33c3ecd8936a18fff21e4f86"
    sha256 cellar: :any,                 sonoma:        "28ebb97379c6b997786346846f91e13c32fd9fd1fe757c800cf2a0698ad5f9d0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0ec3aa076c9dbf32e037899ae09477ef30a7e95abfdb9fb12880761844a0a0f2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef309b33c2b723d8cdde6ca5a4ddf09b11b638bbb4ae162550e10ff6681f9fbd"
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
