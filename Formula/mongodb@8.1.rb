# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.18.0.tgz"
  sha256 "6c36290441d72f2b0520bd8ab1d50c80de4c42240db6ff502e3db04c29bd8b54"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "83c17bcde005414bb8944edceffd278e5714eca7afcbce60faea0668c83cdbdd"
    sha256 cellar: :any,                 arm64_ventura:  "a6e95465db86b69292ef507233eeb388beb891d8b12d18fe67ac0cebd4edcc97"
    sha256 cellar: :any,                 arm64_monterey: "55cbf63ad945b6b90475363dc22c132d9f477be14a912ccd57da749f73b5d930"
    sha256 cellar: :any,                 ventura:        "638d44449d0c9214a3bc4b2276767824e855a59c9e1f3426525b1f806f239826"
    sha256 cellar: :any,                 monterey:       "3fc5c64da03acbdedd8e4c309b951a943f1c378ce71d4ddff04a14714407a6db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8ce929ca341fe40cc0cdb334ada3c90c1faab163efd827f6f8fd49bad348850f"
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
