# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.0.tgz"
  sha256 "5e7db95103d73212ed0edf8887d92184baa5643476045cb899efbcf439847148"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "5ef23b7a8f2f13148eb2bdd4cf46478ece0c8dd474129fed1f0eba7ab4b318e6"
    sha256 cellar: :any,                 arm64_ventura:  "f243b3505940af922613e86c53a1a58c8ccbcb955d9dd51092c06dcd1a448786"
    sha256 cellar: :any,                 arm64_monterey: "e5ce18776b7c7da2794e96c420658739cff7c0366a412b89d51e3f5d15113716"
    sha256 cellar: :any,                 ventura:        "117d9178848e7d081d9486a4eaf1ed9cd76dc7e9cd5c40640ea6a929d76a299d"
    sha256 cellar: :any,                 monterey:       "cd45725204fcb1d2f2d1c28193288447c2d823152155a7d7e0959df11eb2bd80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "30e2447a28a2d8d85cda820271103a269098e5bdf841fef52335b9b009610d09"
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
