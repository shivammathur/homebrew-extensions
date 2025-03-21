# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.16"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia: "00e65b0ec6b28b8dbfd2d9a2460e683eb25ac37074d94b61af0ff0d877423861"
    sha256 cellar: :any,                 arm64_sonoma:  "426b0aadfd86202bcc78debbbf3c133862405810664192ede7c7043f3e51ebed"
    sha256 cellar: :any,                 arm64_ventura: "db02ecef312566590a8fa1f1ed9a1e75a6f279683f5f165bfdadc3e5a50e8164"
    sha256 cellar: :any,                 ventura:       "a76d0f239da204fc86a38dc090873b7e0e6e3bac0e8df8ec3d17bd9946464b06"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bf7d81066ee0d7f228127c95f72bb17a91338c1642f7cd72a0f3898c859b4273"
  end

  depends_on "icu4c@77"
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
