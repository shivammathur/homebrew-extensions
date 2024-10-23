# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "0658b79d914c72c9efd6cb749a0fa31b2112aad9ac6993ca4e5d29de85a7980e"
    sha256 cellar: :any,                 arm64_sonoma:  "b90271081a05485a58998902330654a1ecbd6c1f041055f1ca21ca85e97ce3f4"
    sha256 cellar: :any,                 arm64_ventura: "b326ac12014daeb0b1b4520155f1f1f998c490c291ead491a27f1b05d3d21f37"
    sha256 cellar: :any,                 ventura:       "013e6f529ed4bddad8ba747f55d12b154238b4f72be7e798d18aef381ecde782"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f8c63dd17199affc16c5d64bca97c604fa3be09467202ba0fe377878c7a6e5ac"
  end

  depends_on "icu4c@75"
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
