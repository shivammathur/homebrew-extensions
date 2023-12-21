# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.2.tgz"
  sha256 "84081b780d48af884d47f0339800c3666c664c66f0035c66d43a34a10fb67376"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "01200a0c8e8dfb9a1d181f47d9ce0f4b4ce130c3d257b3d610ef86e2d28b2524"
    sha256 cellar: :any,                 arm64_ventura:  "395f8b5670a8add19f3172fb0313e8808e62dd06e46aa9ca28752c18ef1003bf"
    sha256 cellar: :any,                 arm64_monterey: "0e464c4a2492514eabc268d66cb629c04dc644339cb4cee263173991392f9cee"
    sha256 cellar: :any,                 ventura:        "5ba561bd386bebfb70f8ce4732e0d71db7c2f70501951021112d66beb5cd1cd6"
    sha256 cellar: :any,                 monterey:       "9691420cdcb3056a4c2395378a5617f844a87e48f6eed27977f99157a6a8c6ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5f5394a8b96105d7c13f3a69575fbf5ce7373f7a5cb7d36133d1e3e90231c788"
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
