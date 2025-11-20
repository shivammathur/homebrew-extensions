# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT71 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  revision 4
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.11"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "834131013af3919ebfa752a1c03e58a54348be50f86f8db4cdd6443c829a3c51"
    sha256 cellar: :any,                 arm64_sequoia: "21d6e45f2ef787f16ac1677a8148718fd7b53156145718ab3a7686a7305e1f09"
    sha256 cellar: :any,                 arm64_sonoma:  "4400b33bdc2b884ee8d958b49955965bae059b63c5e7f3a904d746843c7f1e8c"
    sha256 cellar: :any,                 sonoma:        "146feb2d2c1c3ea765c108dfc9a96a4915ecc4676d3a38898a80abcf3b25865c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2b4e3b8f00f855cc2262835d482840264a3aab856d0ba5f833c6f202f35a21d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "db5d5aaf380e222162d67f2f2f4b309335c6534cf62ff3a29c425f23ef9dc0e7"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@3"
  depends_on "snappy"
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
