# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver.git",
      branch:   "master",
      revision: "c0dbf158c99c84cfd487f0bf58f2a25cdc0e872a"
  version "1.10.0"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_big_sur: "30c8240beef4e639158e529ed96927566be0fd5ef343de85b61dfee48c68027d"
    sha256 cellar: :any,                 big_sur:       "0a381cbdcad71a43b9854d41c5e68948dbd0cb39e5109c5a46080559cd516ca9"
    sha256 cellar: :any,                 catalina:      "d0282b31188a59369ee8fb915ae2ea5ad2429c6dc4ffec0cb5afb00fb465266b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e487755ef92ff6c0973cc154f8f01accc74405203009fd3b5f21b29955d8e85c"
  end

  depends_on "icu4c"
  depends_on "snappy"
  depends_on "zstd"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
