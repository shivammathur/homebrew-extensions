# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.1.tgz"
  sha256 "bea8eb86be7e301b1cd3935ee3ccfa052e410a7cfa404ae5ab4b11e4c99b8899"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "c37fb6b26a4bc94649ae186fc1a3b3753854e62beb341045bfd4ee1359ab3d36"
    sha256 cellar: :any,                 arm64_sonoma:  "a7ce62ee6aa916f120d176d82b58088246ac177b8d1848cebf268fbe87a38a19"
    sha256 cellar: :any,                 arm64_ventura: "f4f876ec9b17dcd73f02293ecfec6b89bfccf221fd73cd477cfbd97d7a2061ba"
    sha256 cellar: :any,                 ventura:       "49ceffd2ebefde638d7ddcbc0e6c58cbe793335605ddedbfaf8efabf6beea89c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b5b860b729ca77b98c0358cae0821c2f3e07a98c979c349b3b3e64aad092bb08"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "75ca217adbef0e4adba1e3d4ea9abce1e078188b0e228076ab8361fd2d21d3bc"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
