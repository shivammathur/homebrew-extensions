# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.9.tgz"
  sha256 "05045ef555d042991c6991d4439b85ebcaee5698f3733516f656508131d6e6c3"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "1a1d5df09390f1594ae0078b5ed3e477e7c862162a08f2e9a82608e3541e581c"
    sha256 cellar: :any, arm64_sequoia: "97e87ddb0f774decf56b53e4c07ae9c582877c65fac82dcbe56417a979e3ae54"
    sha256 cellar: :any, arm64_sonoma:  "9df9fe2e938ba1e4d2de439678bcd1efe826f9a6bfa315905cec225b216b46da"
    sha256 cellar: :any, arm64_linux:   "e69599c843bca66fbf51c0ea69712d1ee397a031b22ca930a0e11f2c079cf8b1"
    sha256 cellar: :any, x86_64_linux:  "eb171d8309af7d52ab3d8b32385f3b4d2d868f066f6d69f5109a1ac882ed8828"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
