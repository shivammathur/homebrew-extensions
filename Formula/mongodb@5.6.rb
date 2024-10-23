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
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.7"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "c73000807008e64cf1cc5b485b726e95030615726d8bde2804ded3e5e031848c"
    sha256 cellar: :any,                 arm64_sonoma:  "a9fa4d7d0bc1066a19b16bf09b4c0588022e713b88ad3bf8bc4947fc0b4431de"
    sha256 cellar: :any,                 arm64_ventura: "ae687789a3f2841c851ccbf71ccdbc3b2ad6455bb6a6562d376c4f4c53e9b6e5"
    sha256 cellar: :any,                 ventura:       "5f838649da2df9e1ebc3cc16fdd9bb9eba1a06fd573da29dfd36d9d4adf3c458"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f89fe80b11217578f3257449ea229bfc53fefe6b0ffce9b7955bf30df1e2e6fd"
  end

  depends_on "icu4c@75"
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
