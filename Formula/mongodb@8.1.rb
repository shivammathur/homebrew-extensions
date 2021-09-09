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
      revision: "b27fa4d01995fc3325ac4318d63d4c96d5d2660c"
  version "1.10.0"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_big_sur: "9c46cd141aff9cecaa11ec9fed1fd82c24f4596cdd57229c0dda809609689385"
    sha256 cellar: :any,                 big_sur:       "d0450393420aae7d1017352378aec3d294c60c6ae1fd0df9822fd44684988b26"
    sha256 cellar: :any,                 catalina:      "58545c1153477a446dfa8d618bdd68631a4c4d6630b4ecbf5ecfc6cf4ced65b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9f7de74f21ac8e821ee9af639a914f15a951fd130e3f98e6a96868ff792c0fa7"
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
