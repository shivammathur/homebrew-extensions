# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.1.tgz"
  sha256 "0ca4e21db366cec712cd7077af8ba4fbc8dfcd030997c052a30274c0e5468e9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "30d68290ae3486da6eba5b395835d328a6756951b2991c329c3c54e996a06447"
    sha256 cellar: :any,                 arm64_ventura:  "9507fc0def0c791adfbbe193335d254d13cbadc5f8ed5e693793e6877f311aec"
    sha256 cellar: :any,                 arm64_monterey: "9d2f343b5e420f84d9db182fd59a11b65b7e6f126f9b49b42079eafb1f8cdeff"
    sha256 cellar: :any,                 ventura:        "fef4f0fcd8e7146cf9beae03404fb56bebb48f4ce8ae574d74cdf338962a2a10"
    sha256 cellar: :any,                 monterey:       "b08a268298cb3fa306d49f285f81a489f326e90132b1525566f9bcc47263123f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3d4b49476f119b968c3532b957cc0c9ef016a98a12e3f5c70fec1d36b2c74de3"
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
