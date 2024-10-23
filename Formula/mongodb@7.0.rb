# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT70 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.9.2.tgz"
  sha256 "95e832c5d48ae6e947bdc79f35a9f8f0bbd518f4aa00f1cef6c9eafbae02187d"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.9"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "99f63ebd2695b39a8df177207ec0b73d165125310f09c4d0526145bd21223b7b"
    sha256 cellar: :any,                 arm64_sonoma:  "c90bf4213f8689e3a733becfcbab2d4125608710390d95c187bbdaa573cd5962"
    sha256 cellar: :any,                 arm64_ventura: "1b13ac504f827a05f4e1d52f20dd038b3b44e101acfcf4339b3d8fc87d16cae6"
    sha256 cellar: :any,                 ventura:       "6617284c114bdcaed0b29025401656042f096ac3bfbf8533b581f6ee04c170a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e5d032c04a371d181f8816497da50899bc16e0f0fcc0c8e26969bdce0b8c22c3"
  end

  depends_on "icu4c@75"
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
