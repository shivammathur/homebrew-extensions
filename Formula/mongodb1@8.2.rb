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
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "728eb2823003ceb05b946066bbd85bc2c18e13175a1cc30248f6d64c49a892eb"
    sha256 cellar: :any,                 arm64_sonoma:  "ecb228f638ffa328471ff1a29019d154bb034a8d93d34717d0abbfda789f8fca"
    sha256 cellar: :any,                 arm64_ventura: "95885e704a4bd880f351ef1a948f0fd1ca226b60225108dd1f4aa150e1520c97"
    sha256 cellar: :any,                 ventura:       "982338986f8b6b994e514a8a80c1f7db8dd220756b74972705ea37cfcac99194"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0030a9303d84d71d988a7036c34c2fa4d601a4050978ac97076996c2569874d9"
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
