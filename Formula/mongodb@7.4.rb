# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.2.tgz"
  sha256 "d05fb9ac9846d1ea1cf54e918d2f94f07682ea1e5d181c1a4a756313e0cefa2a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "c5d310f708ab5a5a23f7300fb99087c4a377c6bc961f919f39f881fc9745349d"
    sha256 cellar: :any,                 arm64_big_sur:  "86fe039184663dfbadbb8a0dfd27859ef090250387411993b86730dd70792159"
    sha256 cellar: :any,                 monterey:       "dce47b3730a74ba08b79ee0ade6cd919af8bf0d1979635c218f7e1dbe619a8f6"
    sha256 cellar: :any,                 big_sur:        "6c26954de612442e3c857b3143298efcf807711543ad55f22953a863b1b12db8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "12fa39642be1c73f514952c0f28b99ec2075f832beee119bc197f078eb96e10f"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
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
