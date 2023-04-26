# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT71 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "cbe273cd5de3d5a72b2c771efd275b78a861d175bd9d0ef8a6f54b938cf6ec2c"
    sha256 cellar: :any,                 arm64_big_sur:  "2f3f4bf074a7093dff8bdaae17ccbf09a128043aefb762dbaff149159822aab6"
    sha256 cellar: :any,                 ventura:        "dc62a201aeaa619ff51d9e4071d22443289af28f82440ffeaae3a891d7fe3177"
    sha256 cellar: :any,                 monterey:       "871cb4b4e375da587d9427ab9bac4ab5ef78ad9b93d34cfb09dd1b63825ca59a"
    sha256 cellar: :any,                 big_sur:        "1ab3b80cde76c02c14bc5b4764e16d3269e7247ad77aaa253b57b78105d8a7a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a538e768839142b9a802b1995b0ddac14d5c8bac4e8c4318e4822f9bcf258b06"
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
