# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.18.0.tgz"
  sha256 "6c36290441d72f2b0520bd8ab1d50c80de4c42240db6ff502e3db04c29bd8b54"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "99743ed810a590eee48d33f8cdb99ced98f70150ce856383db1a8c646ee08144"
    sha256 cellar: :any,                 arm64_ventura:  "4e5dfa6f4517537c2c8268dee80bf130e2a8762636664aa8c3e03ba44f180b65"
    sha256 cellar: :any,                 arm64_monterey: "b1f26614067652eca029f052e18bf3aa0257dd3b71351ebce9ae0ebfe39c3bb0"
    sha256 cellar: :any,                 ventura:        "cccc0b8b680ee25d678072e7be56d51a2f74ed8d2dbd6a348d7d2381a030922f"
    sha256 cellar: :any,                 monterey:       "b5fa62bb6d8b2bfcbca9b011452a040f6dd938b5014b1541a5efce0c246a6c4d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4abf19255a40173a10bfa78b639a7e562b376831f239632f82d679ad18eaf5c5"
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
