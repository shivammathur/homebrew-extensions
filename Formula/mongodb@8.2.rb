# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.18.1.tgz"
  sha256 "f957b71154052fa9706ce703f4f8043cfe2655367455483798b59269ebe9f135"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "e64fa1770556491753597b5bc4015f4842da307c0b564b57982b31916de22402"
    sha256 cellar: :any,                 arm64_ventura:  "99c30765bc688eb4a0d300c29616a368041a9fec3210f6a72c1eca84c0824291"
    sha256 cellar: :any,                 arm64_monterey: "82d12b0514dec9c3110ce07fd07e310dddc0381c3daa2409a983466ce1398095"
    sha256 cellar: :any,                 ventura:        "32b8cbfc5b7f4ac0889044427e04d9a605e5d3997827d854e0e42e0803d686eb"
    sha256 cellar: :any,                 monterey:       "bbfe47088273b40a9265d505eeb2685219176da7978fcfdad1e5e3c00f02f958"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d3835c0711597ca4c4b2490ad74bf2b45dd6c46f13b837715acea84eb7b86e39"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
