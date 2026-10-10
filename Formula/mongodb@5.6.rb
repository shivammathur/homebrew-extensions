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
  revision 5
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.7"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "e388455ba8db4be5d5a95d2746eb9c83c34ad5fcba9f8999f81db1579701f87e"
    sha256 cellar: :any, arm64_tahoe:       "71291235fe091875f9c6e7dc70c0d589e2bda0314e9e8b9c8e9efbb2f3ee06ae"
    sha256 cellar: :any, arm64_sequoia:     "01ba23553847b97bed8dcc5f8395ce28bc01271d3d04af59cbfad7ca7735adf4"
    sha256 cellar: :any, arm64_linux:       "76009c4c25a07131e8579831b9fc064109454121bfe3c4ed6d97504e3495d7ae"
    sha256 cellar: :any, x86_64_linux:      "ffd0e1483ba947385a629d77db6f2c7cf61efa6ba5717c67ed582e8a4f78ef99"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
  depends_on "snappy"

  on_linux do
    depends_on "zlib-ng-compat"
  end

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
