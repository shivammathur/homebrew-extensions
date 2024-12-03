# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.1.tgz"
  sha256 "614e57594918feb621f525e6516d59ce09b78f5172355ba8afb6c2207c1ce900"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "6866098edd5ec0cba65c3528bcfeba65d3dadffe5ac1c8309ab3840ce6d2ae53"
    sha256 cellar: :any,                 arm64_sonoma:  "d4a06f8562ef0c3b3877abb4b2a1f12d688bf92a9e6ec3d30e91f754848ef4c8"
    sha256 cellar: :any,                 arm64_ventura: "d4784cee03d811a90144edd5dd7f9db4a97ac0fd3f45f2cea7dcd66a2b38a901"
    sha256 cellar: :any,                 ventura:       "6a988671e76e528859bc2f7d48d13d4060bbd01a1cc4d77f6183b6ad26327591"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b1371bd17cc296878d467fe7b401fab9a7519db7203a981e589e62e9ce1dba9d"
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
