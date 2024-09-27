# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "569f55d897e50c1c47f3fb59b0216b16ec4c13f66886b5c372a3c5637daf0c11"
    sha256 cellar: :any,                 arm64_sonoma:  "14dd41025d8a22f86c1337197ecf4f3f0fad5589106d637e6d46b7a52aa6a02d"
    sha256 cellar: :any,                 arm64_ventura: "7fda95ef12f68213a1531ec13905190db17a288313b28b8d31133405fe7d31be"
    sha256 cellar: :any,                 ventura:       "1f5388beb98ad23528b6dcd5b1009c14a7b10fb6fc5f5b7d2284374e22c92bea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "48b0a8058fbb3c84d1ad0c72533cd105840268620a507a9ea0486db0e96322c0"
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
