# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "973b56ef67657610c2ab75aaed2b948ceaa8dc093f985acb7f27179a4ec10b4d"
    sha256 cellar: :any,                 arm64_sonoma:  "959cc9495f58bdf78a11ff7b347ca23b218466968892b72b6aa2910964196bc0"
    sha256 cellar: :any,                 arm64_ventura: "120d31c58314f8fdb9203fb535e1a64b842e5ea671fe3c66cfe8e6c68447b7a1"
    sha256 cellar: :any,                 ventura:       "1ecb202b10b88af07a487b9e7c8d31144e8ae6a056df48610fc1a930cd4344f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3409d4d99e907929d6626039a00ba2064b4bab8f8322da9be2b2ec12e0ac65ee"
  end

  depends_on "icu4c@76"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
