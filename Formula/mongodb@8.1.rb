# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.2.tgz"
  sha256 "04a82c33710d36bda551522f33067d334dd20945f4db680cca5485d10e8aa5c7"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "9a29dc3b2f1bf76434c29d5539b1b13d6c2ffc4fa4b57cccdbf87c3fd5c80019"
    sha256 cellar: :any,                 arm64_ventura:  "d809994274583ffd3d1a81078016bb190740f785062e28c9cad53bab95a8af67"
    sha256 cellar: :any,                 arm64_monterey: "e1174fae78ce2a23c53aa198d1abd287c750abdc2e7fc90277fd5935180520a5"
    sha256 cellar: :any,                 ventura:        "63a8ef6e4ddfd3b57aa39ab7b2e41b11131454b0ab0dcef64899a97116a8b372"
    sha256 cellar: :any,                 monterey:       "76658d688a0efa04a4863dae45a12df70d19d00f8666987edaf2deefa6072544"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "531a0474cc98339d13ab2ba762ea333fa46f3831740d93646aa8591e454e1c2c"
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
