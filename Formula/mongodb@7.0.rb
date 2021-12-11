# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT70 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.9.2.tgz"
  sha256 "95e832c5d48ae6e947bdc79f35a9f8f0bbd518f4aa00f1cef6c9eafbae02187d"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_big_sur: "fbd58acd94394e741e4dbe543f8e0e9d2627cf7cb10b4fc4769398dbdf055453"
    sha256                               big_sur:       "99a464368fe3c8fb1ab4606cdfd8b8fec358f7c62226db8073d8ea59390e50c4"
    sha256                               catalina:      "c78857131c02620706417b755716f6a827b347412f8bf059e9005eb11b40f202"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fe357351b96ec331f8095aa069ca04e7452ee1e907ad771028cb55a12fb9f386"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
  depends_on "snappy"
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
