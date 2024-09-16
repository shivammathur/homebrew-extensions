# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "500d37d3348087610f1e24f96f39849bd3137b17f306375b96554a2573bf982f"
    sha256 cellar: :any,                 arm64_sonoma:   "1b1603c3dead66e1c094369627fc1f873969b7eb3672da1b44d2fa3310f0b8f7"
    sha256 cellar: :any,                 arm64_ventura:  "3aad72ce3463aa8afad092fe34b0a69f8c4ae6b9703ad8287445cb58fe0e0d62"
    sha256 cellar: :any,                 arm64_monterey: "07fc549cde636b9d5c8cb884ae39212d7f1fada9b48568a47cb0fdd0227e89ef"
    sha256 cellar: :any,                 ventura:        "18be3da37175218847592a8edb98456c52efc2c82dcd1a822c4b105b23a75fa3"
    sha256 cellar: :any,                 monterey:       "5cb34fd7106181cbbfafdaa095a7a70ac39f97c98538b8bb86807a60fb080dba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "56d19836d8cf0ba5f512a7fc2ffeb2f1aa389c1372734cbbe062ab9d48eff885"
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
