# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.2.tgz"
  sha256 "04a82c33710d36bda551522f33067d334dd20945f4db680cca5485d10e8aa5c7"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "90830c91bfa3fea1caa855305e7763d757ace892a8eaa339ecb9348aa5c6f685"
    sha256 cellar: :any,                 arm64_ventura:  "ecb606748526b6777093507c7beafaf5da103ebf6edfb10984b98d3bfd2b5863"
    sha256 cellar: :any,                 arm64_monterey: "cd577d0289e0e4cd94fc88e8ac7ebdacca1548f4b1357f9a8b359bddc803132d"
    sha256 cellar: :any,                 ventura:        "6826006368f4be7801ca0f5f3d49821a9bd2c68b563e210338f0bd0b6d21507f"
    sha256 cellar: :any,                 monterey:       "fd2f8c59fdcf8f6be92060f40b530accb25bcfbea66956b283a1de88bf5ac520"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6739fc0a229e30cf52e31d99fba1e93e501a4d210a3ee7360a6df96efe6024d9"
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
