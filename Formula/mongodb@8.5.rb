# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "af277df62b04d21027d2054ea1eee230c83d17518deb4e7543c13730ddabc0ab"
    sha256 cellar: :any,                 arm64_sonoma:  "5b9b74e34b5bb662126ee7886a135fe4da33bc23bac1f9152a227721520c3e44"
    sha256 cellar: :any,                 arm64_ventura: "ec10f4eb651a91a7e6ce2343d92a169b9b4524760acc06286d42d60f28b1c900"
    sha256 cellar: :any,                 ventura:       "0a878d1f28e53687c92ff8b5374f1a649d4d8ed3cd499dcb90333639ca085adf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1d528cff9cc5c412015bd1aa45aabede19545813cdbdb365adbe233a7ebe85d3"
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
