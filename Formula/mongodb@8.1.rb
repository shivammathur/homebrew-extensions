# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "de4ef80a459d2d48bb859a15db89a9c143c791134b90710384fb9cf1d210e2a1"
    sha256 cellar: :any,                 arm64_sonoma:  "bccbb19a2b5a88f550c1cd9eeb2b32805c2da95e85754ea9b9a68bbefeb91f8e"
    sha256 cellar: :any,                 arm64_ventura: "f146b25370985ba8e67cfd290ddfa2fb414018844ab87a9eea6aa1153266a072"
    sha256 cellar: :any,                 ventura:       "c6dce57e84e072a43a8a602f03cdf93ff6290529ab94774b0435a203b64c1819"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "03ce97424d0e61f78482eda7f0c8716eca6736a166585b475befa4cf626231b2"
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
