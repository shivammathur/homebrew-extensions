# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.2.tgz"
  sha256 "84081b780d48af884d47f0339800c3666c664c66f0035c66d43a34a10fb67376"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "85ad68c6ed18ec6ca32962540a483125ad557d3ddddf17eba79f73ab44adea5f"
    sha256 cellar: :any,                 arm64_ventura:  "11ef21b5ee591b9af56f360755d2cc79882512eba52a65cc759dc4fcad310dda"
    sha256 cellar: :any,                 arm64_monterey: "903ddeb3db88efd0ac365c81bce7fbfc81fab7ceed7bfce74fd699bee7d8b4a6"
    sha256 cellar: :any,                 ventura:        "13a1806311a4899df660ac335d5a39dd5b7fcdca3c56d877b8831794c68dc02e"
    sha256 cellar: :any,                 monterey:       "2d671200005622f711d18043c630dd2818eceaa473c5b4de27733a1387acf543"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7a43d6962c932964df8c872b1b2e56d215163aa9c0404c7def439583e4463c0c"
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
