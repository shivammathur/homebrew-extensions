# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.2.tgz"
  sha256 "84081b780d48af884d47f0339800c3666c664c66f0035c66d43a34a10fb67376"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "bbcae9884b00dc56b8b8f68bcc5f7cd389bf3510e65347c0b79f536449035bac"
    sha256 cellar: :any,                 arm64_ventura:  "a4e97152e4d1535c0fae7f117b4f8bcd8485373eecb594812cc06c6ad86a7936"
    sha256 cellar: :any,                 arm64_monterey: "22b5d5de74a62e20eda7148daed54dbc94b16e7f9945ff293ae0bfd3836aa09f"
    sha256 cellar: :any,                 ventura:        "e8bf3fad85e0f71349568aab59dded2066a0564d9892e2c002528489932b7388"
    sha256 cellar: :any,                 monterey:       "3d34160381b0bd53416381196884ce8e160dcabfc26bd011415d7dfddba67b04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b62145de378608da7dc34a35787ec3104922f47ddc7787c71e27404d18e42160"
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
