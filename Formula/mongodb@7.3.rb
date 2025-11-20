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
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.16"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "9fbea6f85c18c468510e89eb5c5cd73036ec18705a88e2138621d89248b6ae21"
    sha256 cellar: :any,                 arm64_sequoia: "14315fca2cc4e38fd2c7040507115ebfbb30522d6a133b36499c9328cdec5815"
    sha256 cellar: :any,                 arm64_sonoma:  "17a430dcc5712ac56ae4288b9bdb4b67cbd8e07e24a8d33ab42c9d1cd71cc814"
    sha256 cellar: :any,                 sonoma:        "07bfa528ffe95a8984a2d49d64d15ce62cfd998e8240fb81a1c3f559426949fa"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "96193f33b79dd31f0a343275f067c8f08f20bcbba17425aa3a5543f24a48eaa4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b0f51861d02815e965e4f3bf5f35d37eef94bcb63b5726cc76135b6686949dce"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
