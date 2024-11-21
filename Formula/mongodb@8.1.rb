# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "3a250cd85cbd5b9a06b8e69de34410cda7d1e8687c4d22c7d8df9e150ca4ab00"
    sha256 cellar: :any,                 arm64_sonoma:  "cfde574d3500d1f9bcacc695a0e97874d49bbf5afab482bb44b48b0e04d855e9"
    sha256 cellar: :any,                 arm64_ventura: "8f82711e229ba6e557c646e6aab4a8ae4924c7b574a7714654f69b6daadcbf10"
    sha256 cellar: :any,                 ventura:       "3fdad7f066dd03c565b460acd47d6cd62324484f06720feb05c79ab611131141"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0226ba806b130741e3aea04ca5d5133af05fef06eb01007a065aec292180c5b4"
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
