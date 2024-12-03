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
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "9855138c0b5c633776be1c6b6f677e25072ecd75c73e258e37d8bf6a782ab7d4"
    sha256 cellar: :any,                 arm64_sonoma:  "b74c93586f3497aec279e0bd6b02807fb8f21180d29d171ac624377eba77c90e"
    sha256 cellar: :any,                 arm64_ventura: "310117a1eab8a8d2ac5b22ce450d9f18197d22efac3020329354fc1eddc4d5bd"
    sha256 cellar: :any,                 ventura:       "a99c7d6caf9909984a733cbb0ba7afcef255c281f3271506b7c02f54812aa0ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b3e4888c57e7be67965da67fb53b840c1a7781c6ccd345de49ec40036b8ef3ed"
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
