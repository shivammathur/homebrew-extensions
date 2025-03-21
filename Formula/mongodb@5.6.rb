# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT56 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.7.5.tgz"
  sha256 "e48a07618c0ae8be628299991b5f481861c891a22544a2365a63361cc181c379"
  revision 3
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.7"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia: "0552f2a7c183a1a0fdab0ba6ff415031376172c898024d7c550744781426432d"
    sha256 cellar: :any,                 arm64_sonoma:  "41490832e7f414b5744e690e0c50ce7a3466c8f3ff2c5479bc5a6284aac4823f"
    sha256 cellar: :any,                 arm64_ventura: "b4363f0c1eccd6babfa96188896a1e2ffc3d2ad3cb1054ecf35c6e8323d52388"
    sha256 cellar: :any,                 ventura:       "cd6c0b1921ffb1e36c92ddb37c4228d6c08cde698fc91edcfd5809b79234fc0b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "829bae127c0049be8fda9e05a5361aec7b7ca75a0279e5197c96a1ea7a63385c"
  end

  depends_on "icu4c@77"
  depends_on "openssl@3"
  depends_on "snappy"

  uses_from_macos "zlib"

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
