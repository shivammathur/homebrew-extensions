# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.4.tgz"
  sha256 "ad299dfc4f69859acdb82d7eca5140833370dce31ebbe2c628e716ed3167b841"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e43b90c08e63bb62c31dc440c0c47efbd0d6acb40dfe5384746fa1d0ae47b0e0"
    sha256 cellar: :any,                 arm64_sequoia: "e3da5ca2d2ca16b8b66c71f4a56da630fdb2809535cef6e97d377ca9494432c5"
    sha256 cellar: :any,                 arm64_sonoma:  "772bdf31fa2faa65d48637e730835158127e74aece9f85e4475176ad8366bb1f"
    sha256 cellar: :any,                 sonoma:        "501417a0bab80beff1f6caae0a06d9fa6327cca240e5e066c20583e4a937ef29"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ae3edc32a4e0a6e34bc38991e3f392b72c3c8ba9aa22e4e14ff9ea92cf9fdd8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fee20f59b534f98da7517b3dbccfc955025a3df193a304f7fea03dc9f3b9272d"
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
