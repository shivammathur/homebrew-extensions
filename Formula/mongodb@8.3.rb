# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.0.tgz"
  sha256 "5e7db95103d73212ed0edf8887d92184baa5643476045cb899efbcf439847148"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "0c69f0dba28a44ce1e7235e0cbe4351dd2255b8a99a8e7aa8279cf0f433ddadc"
    sha256 cellar: :any,                 arm64_ventura:  "0e7ee6463697d4e370e3d5fecf72ae15daee27fefc711e3110bae9333802353a"
    sha256 cellar: :any,                 arm64_monterey: "6467b0150e35d6afc8ccae1cedd0cd6b0015d8c1354837c374a2a50c11e09204"
    sha256 cellar: :any,                 ventura:        "99e760264e68e12217bdd0c73c62a4e6b3befbe02c60fce7f8c0003685b0a08f"
    sha256 cellar: :any,                 monterey:       "e4a27285d87b3494c97f3262c92142607247e1b14201b9dd0263544c248cb7a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b0bf06ab3461733bfc86906125df5f396085890c7db9c2c684af0d195bd68cac"
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
