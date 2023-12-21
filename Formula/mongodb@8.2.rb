# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.2.tgz"
  sha256 "84081b780d48af884d47f0339800c3666c664c66f0035c66d43a34a10fb67376"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "940a2a35d5899e2de967a4acbc830ab4f69e6cbb8fc6aca4403d61b1ade76970"
    sha256 cellar: :any,                 arm64_ventura:  "13cd570f97e953b5170e889aee9074f28a1c9109b00a6600831e1193dc2dde2e"
    sha256 cellar: :any,                 arm64_monterey: "d91bd637a0041c11331df28bf35692489d1dcb9ed129e3df09a3e4fb092c4149"
    sha256 cellar: :any,                 ventura:        "aa840bb935e9f292dfd124ac30541e4495db9d64926689225230cffc3b27e87d"
    sha256 cellar: :any,                 monterey:       "4e1169f54bc3741308b6533d975dbd09d9f371c0c33e591830a6debacd4d08a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dff0277c6bfc7bad6ef1d2cecb81bb09c98472109cebd18ef8a5760bd47c6623"
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
