# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.2.tgz"
  sha256 "04a82c33710d36bda551522f33067d334dd20945f4db680cca5485d10e8aa5c7"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "e915ae7e383e1821069992d80d9605b2c174a6862cc5f5054586f6aac3d98b95"
    sha256 cellar: :any,                 arm64_ventura:  "17067644e61c7a381c71d676d16e03c2e582d19128d5bfb859c9a99244961a0b"
    sha256 cellar: :any,                 arm64_monterey: "6f2381eeaf668c0177749975a126297213c4e05a80ab48487f9b65de40287444"
    sha256 cellar: :any,                 ventura:        "311ba9f261fa4c4b2a3b98a1a7a540a254983cbe007013e6a465e7b24c9ecd02"
    sha256 cellar: :any,                 monterey:       "fa5de6fc1d60eda7bb893db0cdf171d0d4b056f40b1bfb40100a51d458a7d221"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ffec96677c6d8b9fef57ac241de5f238fa47d97a31f36d278f7a27525172320d"
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
