# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.2.tgz"
  sha256 "04a82c33710d36bda551522f33067d334dd20945f4db680cca5485d10e8aa5c7"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "682b7929a0090fcd572d292a5425d27cfb57edbdc255d4a629dfc050dea04852"
    sha256 cellar: :any,                 arm64_ventura:  "cc4cfd52b1ecc5910d0c8d44e5386f46d02936860afd52d40cd7d8255658033d"
    sha256 cellar: :any,                 arm64_monterey: "2d07980b2864896739d6069eac85117b7171974571749f19a1e7c850bf0ea09f"
    sha256 cellar: :any,                 ventura:        "412afaf811a96defc0f3d4d4689933d74797e5cabca273ddec6e41fd7c80e402"
    sha256 cellar: :any,                 monterey:       "a868e69b8f09f2b35e1d7b1aae867e1df7cbcedbc227df8987bdbf048c0e860e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cf808508171ca8cf34cd423cac7db65e6372467a996f47ed8c73a3ede7b04831"
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
