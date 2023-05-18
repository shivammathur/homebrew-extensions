# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.3.tgz"
  sha256 "4f2c4e417fb606b462e870ec03656f3a97ba0b399dc24a6d9d153e9846134388"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "298cb4f3eff816b0f27359c4efe6bf41a06252cecf2367b439af8b5c348ae118"
    sha256 cellar: :any,                 arm64_big_sur:  "10d4dd950ac9e21a6b49cc48fea14a6a710e3203651b45761a6ebfe9015378d4"
    sha256 cellar: :any,                 ventura:        "ff780c9711df16fa37cf6c8de8227e97dec29afc426870c07f3726c3bba7c646"
    sha256 cellar: :any,                 monterey:       "c2202fd71a81adfcb4319567bba087121c428296a523f14e12d240cad12a9516"
    sha256 cellar: :any,                 big_sur:        "857b0a75f876306590e002bf5c8d70d06ffc9b465a19e394b0bb3b0ca85e374b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "854306dd6bfbdfbc44e00cecdd9366b08055989860b9b7225421a71d66be142b"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
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
