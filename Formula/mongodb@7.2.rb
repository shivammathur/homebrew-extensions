# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.16"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "0cdf846c925a07c24086a0efb5586ebf1c1ea27ca9d79543744298a88b836eec"
    sha256 cellar: :any,                 arm64_sonoma:  "6f3095b5d20b4d7946efd79869edc6959514155bb721172aab1796bcb59adcad"
    sha256 cellar: :any,                 arm64_ventura: "3477d0e50c797fa80f199b63dabb00b54c61e96543f6ec2cc7d8c0b5f5e1ce24"
    sha256 cellar: :any,                 ventura:       "dae952ac15fe5c8d181ae7c00af72a57a2a72b9e71f44b506aa102c1832a32a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "40bd5a29e133ac6663b749c49712ff4133a98537c1caae04bfa8b01ba196747e"
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
