# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.1.tgz"
  sha256 "357e1f4f6b9f6f6970789f5186467da1960dff2db2a8d6474f69ad51a37b5f72"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "3829267cf1e15bc57fdd64f735b682b3746ece91eebd5136f27492a669cf9c1d"
    sha256 cellar: :any,                 arm64_sonoma:  "c4f8336e82ca9bfeca84ae22faab760f86008f419b1c36ef260972f2b0d25537"
    sha256 cellar: :any,                 arm64_ventura: "1ecd71c2937d47bc355b6445867af4f58b60451a34efd1fd9091ed4c84640013"
    sha256 cellar: :any,                 ventura:       "10b96ae31e3545b843575b4d308f36c411caf22d62b143d4ce9b338acf18eb04"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0d73ba06bd6d3237419e349e8156a9a96e1739e8eb056e76dff75cc81296d89a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "19c49941b4aa16260c199f7e31cd7bbc2d9e372ed0c4885d308b3414fe3847de"
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
