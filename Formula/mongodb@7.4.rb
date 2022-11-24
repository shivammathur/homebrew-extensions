# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "10231a8e6353053f2197bae03f34b6e6646a54c2f1172f865d50bb51b91f0b62"
    sha256 cellar: :any,                 arm64_big_sur:  "9e858578ff3fabf9525ab7dc4179247d9e343f662b739449f6e2e1736faf48b0"
    sha256 cellar: :any,                 monterey:       "d1b2454347d16ed73a36bee14d87514abd0fac6a24a59d859ca4a341abca59b5"
    sha256 cellar: :any,                 big_sur:        "67d0a09a44248e3415cf527751e4a7a81fb9bf7ba5cd1674ac7cbfa69f891b7f"
    sha256 cellar: :any,                 catalina:       "3f8e39f3113e1ff3f3f692209fc661da945e2604cf590daf3e4c213d34e3a3cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5ed0b43629496a739e72a48b26f607836c4a0556b1426bcfb27a42a3925b3ddf"
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
