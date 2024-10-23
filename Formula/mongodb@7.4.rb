# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "f1d62d01b9318e4cef3a4f64911245e17d053d7257e4b0058214325da5583d78"
    sha256 cellar: :any,                 arm64_sonoma:  "059d2774ff10ea63706092c5ede33babd5ac8e679ca17f557b23faee37b9b18d"
    sha256 cellar: :any,                 arm64_ventura: "5b7c66f365de603af17c706a68cb7ef8b27f642d7a1a2bc76886b2b295058c29"
    sha256 cellar: :any,                 ventura:       "ecbbdd20424dbae1173880cd33bf70ed8a2e4c7c1147e8c30184fd64756ea55e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8b530bb5936d5c06d27937833256ed08d5f81cd5d913bfd36c1e40eb6bf7bce2"
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
