# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.1.tgz"
  sha256 "0ca4e21db366cec712cd7077af8ba4fbc8dfcd030997c052a30274c0e5468e9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "f84175366b9a958f8b9db57de48362f19aa4522c5661e5ba9aad3c5ec34d54c6"
    sha256 cellar: :any,                 arm64_ventura:  "dd291c9c16d1f0a9acee5c5ce3ee919132e0f130f43261c9977816f65a641781"
    sha256 cellar: :any,                 arm64_monterey: "abd4aef8a5eef733a9896d82230561110a7801d8247720c2b2b0f6d5220d78cf"
    sha256 cellar: :any,                 ventura:        "ce214508b6c18bf03582c7251bdd1d47c1a051c7d3af0420533cacfc2ad42077"
    sha256 cellar: :any,                 monterey:       "e4393fa750fbe69d38c02b366d2c76b7ac5813d56ee00aa5fba9d62bb96ba393"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a563e43b6a6a9ced758531e7c0215ca64266e3394da40f2c671f3945833553c8"
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
