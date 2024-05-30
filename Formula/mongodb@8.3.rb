# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.1.tgz"
  sha256 "0ca4e21db366cec712cd7077af8ba4fbc8dfcd030997c052a30274c0e5468e9a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "dbdd47eb08268aa69182a19bb7a52807293c473e74cc03d12c45c5b9e59ac98f"
    sha256 cellar: :any,                 arm64_ventura:  "3b8562d7fdf5bd3dbf46a04f8e5ab49c896b8dd7aafe0d4c4be4c7b66b65f0fb"
    sha256 cellar: :any,                 arm64_monterey: "9b3114c81fc81d6932c09480f2d2d80d9c2c42cef204c2ff0794ddb5da78d6ed"
    sha256 cellar: :any,                 ventura:        "42463d6c3fc08f591a7cb88529310cf1097ec582b65c49f53e2ff1db65f3bbad"
    sha256 cellar: :any,                 monterey:       "e7fa298031a877e2b8fb574061361621c2006725cc994ab65c983d972d1f165a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3eaf024da373cd677e8f38b92dee313d77d596206e9df52525607cad777734cf"
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
