# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.4.tgz"
  sha256 "57c168b24a7d07f73367e4b134eb911ad1170ba7d203bc475f6ef1b860c16701"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "a82660f23ca375cea79d222e8f643346da6f3a871c63e2ec9064d05271346eea"
    sha256 cellar: :any,                 arm64_sonoma:   "9162c97eddda2758f4eb579ed41f9d8d7397ad066278e7603b8de3c4775d045d"
    sha256 cellar: :any,                 arm64_ventura:  "345c9bc47e8c17339e3d6ccf60a815f1cf5e6d1eb9c6996d02a2e6662c74b646"
    sha256 cellar: :any,                 arm64_monterey: "644ffa32414128242119bf24c283237bb7179ac3b1663aa85cd47730494b29ca"
    sha256 cellar: :any,                 ventura:        "29f8787387112cad5d0a77c6873c03ec804f8c1495b9cd449813fc698edb45b1"
    sha256 cellar: :any,                 monterey:       "f63d674174fb612c7a7462432109e77df01953fbb02cb26dc6fbcf9fd601194f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "da379e33bbe999812e1e982dbe4b0e9b93c956dd68c12c3c6585933c64d97372"
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
