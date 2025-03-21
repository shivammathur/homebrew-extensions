# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT71 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  revision 3
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.11"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "1d9b2dc67fa479a4ceb0328f18ef2703d6e4ac3470d20fbe1ea3a4d214587cc0"
    sha256 cellar: :any,                 arm64_sonoma:  "513203b10862c6de1c5d812584b735c43ede481033ccbece70ce3bbef82c211c"
    sha256 cellar: :any,                 arm64_ventura: "69706e51c41bd9144361e0d61b8822c8eb4d1da5b67e1188135925d33f4e0c52"
    sha256 cellar: :any,                 ventura:       "a69823fe1d16aca4dd4e6ab8e50ddf2c3461bae41cf0902926ac9288db174351"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e4d7b738aa9fbc4c24da32e00ddb1d4b893c0a5e162ff936cc781e66594ca83e"
  end

  depends_on "icu4c@77"
  depends_on "openssl@3"
  depends_on "snappy"
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
