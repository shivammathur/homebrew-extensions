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
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "7e146037f33f161c7f0eb5420aef87f074ffd964005080902494116118fb49b9"
    sha256 cellar: :any,                 arm64_big_sur:  "3362354da45e16cc0a24811ef49abf49ea0df93a6044cbedd1bb052aa4ab08cc"
    sha256 cellar: :any,                 ventura:        "beaf2a234175d072e540e9352b6060b981a55e97362608b1748300156e55366b"
    sha256 cellar: :any,                 monterey:       "0e9da4775fea214e03d1bd23e90009ac9d471a7939ddf078ca15c05e49120d76"
    sha256 cellar: :any,                 big_sur:        "036e1aa82b6c24ec4c18e03c70f5082a5fdef7d710eefb3db4d0e6dbc097a787"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c9247088926a7715f0d80056c139df6d9fc132f3076398ab7c185a96a05d3067"
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
