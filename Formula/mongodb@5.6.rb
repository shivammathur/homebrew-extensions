# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT56 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.7.5.tgz"
  sha256 "e48a07618c0ae8be628299991b5f481861c891a22544a2365a63361cc181c379"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "935fce23bb0c23be5de3fd969f9842ce266f69fc7eaf0ec73118ef11156b1f49"
    sha256 cellar: :any,                 arm64_big_sur:  "f9b1bd9809ccd2bb730510fe4d6ef54633ffc137b985922c826e4d7ecaf10147"
    sha256 cellar: :any,                 monterey:       "c45d9e1c8d03e5402d00a2ce0e29371ad3c0d795415758c2446d05ff5fd53463"
    sha256 cellar: :any,                 big_sur:        "62738f87610453b967ed16c0b53347d7ac2dec7eb0c7a40ed5fe2eff06c4d306"
    sha256 cellar: :any,                 catalina:       "d0795bc206763473c7d10f05f13da5c8fa583e8511a894f0875b141e1e7252e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4f6c064176aae1fabd96d1ef15004d8485ec6fc56ff699a0912caf94eab250cd"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
  depends_on "snappy"

  uses_from_macos "zlib"

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
