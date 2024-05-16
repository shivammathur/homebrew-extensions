# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.0.tgz"
  sha256 "2bbe89825196676e8932c87f0595922e2b1bb18a6f982ee5f37ebdc447b14d10"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "bbbec4251fad4b7bc4e71d3a48dc006aa44109debe05ea06cd21ad6d1fa80b7c"
    sha256 cellar: :any,                 arm64_ventura:  "af8912adc1be50764f497df28428f098439ae0328739d56f38a3f7c00820b97a"
    sha256 cellar: :any,                 arm64_monterey: "5a2474673208025e365f8a6365de01c2c8892faed6907251a40cd5306256f978"
    sha256 cellar: :any,                 ventura:        "73238ca94a4d2e662ff6ed7f1911c2849707596a99db15941768c228388127f1"
    sha256 cellar: :any,                 monterey:       "276e811f1fe5c65be89372bebab267bb9b00a129d3b736d7b09eceef693ec9e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f7434b285a8951e0e55dd12dac5a8f282f1641c73232c18251b5e653b3831b72"
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
