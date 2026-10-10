# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.1.tgz"
  sha256 "614e57594918feb621f525e6516d59ce09b78f5172355ba8afb6c2207c1ce900"
  revision 3
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "08dca302c90519d74cc12ab522530f6941f2ccb2275456b28e28555a7aeeffde"
    sha256 cellar: :any, arm64_tahoe:       "2eb9f63751ee12112cea39698130e4b849ba46337bba3fef1d0cab0ca475beeb"
    sha256 cellar: :any, arm64_sequoia:     "2e4d033be4d12ac37bbae83ae1e893ade9c5a1d6c2f0bc803b84f16ad87dc8ac"
    sha256 cellar: :any, arm64_linux:       "4d12e7b8aef7b2bce53113703b32aab0c15056f3feaadabd4d1e10981ddacad0"
    sha256 cellar: :any, x86_64_linux:      "c0388ec9eb5ef3ea89e108bf4fc49c27f1e50ae0200b881680875b9a60559d84"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
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
