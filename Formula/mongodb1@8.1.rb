# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "b93e95e31689f2a8dd5b0f96e47ab93f6f911d9a8ec6371cd70bdf5e48034562"
    sha256 cellar: :any,                 arm64_sonoma:  "69d8e34c9fcec4f06050cc3616d324f8cba1e309dc0edd3aa227942bda765815"
    sha256 cellar: :any,                 arm64_ventura: "1da51ea63cc40467031e9da9b3939ffef4b3490ee40ae6490a26d4e765b8a921"
    sha256 cellar: :any,                 ventura:       "7c66462743cd988a7d0556efc2eacd825d75a23de43c797ce7d0d25883d71007"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4104c37c83f5d8c002e8d4103b5368ce284e15c98aab3a2e76a4a9496c154cab"
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
