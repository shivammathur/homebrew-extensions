# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "84ed1ee8b6860c7824d154c2fbe3064a2013d6c483d26488bd6e6f30d632a19a"
    sha256 cellar: :any, arm64_tahoe:       "6b8adfd898b4202aaed44d561635e90f107ed1581a12c9a558a4bf9099219732"
    sha256 cellar: :any, arm64_sequoia:     "5cb1c0b4caf30e3a7c4ceade3c90faea5410c00329154e7f664b8952b02e9afc"
    sha256 cellar: :any, arm64_linux:       "04b31770dbe40b7dc1a2888d37692f78be580436700d98ceb10d5d2c5e60b1c1"
    sha256 cellar: :any, x86_64_linux:      "8a42648d0cce43e60ccbf2e647a2c9f70f793d8756233fd365e97c98057272a4"
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
