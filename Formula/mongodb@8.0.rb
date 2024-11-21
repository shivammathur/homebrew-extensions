# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "f47dd7fc5416d38381b705d0d78bd2870bd40948710cb44c7c5e835af189d80f"
    sha256 cellar: :any,                 arm64_sonoma:  "14d91979026cacd61e6f6793fc6c989ee64e513bd0e01dc2c06ae11bcd1ecce7"
    sha256 cellar: :any,                 arm64_ventura: "1d1f4918e086acbd1cc23054fcc7c34f022aa40c2e5cd4102eb3705877c9fc41"
    sha256 cellar: :any,                 ventura:       "07bb354c2b3bc980a6144700ab8275cbfc3751e9af1d00cfe800870fecb94884"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "081c6dfea71ef0dbd890467b82f34366aa7d877103592906082d87f293483155"
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
