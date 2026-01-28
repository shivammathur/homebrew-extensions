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
    sha256 cellar: :any,                 arm64_tahoe:   "4d0859c70dccd7fb4e33f784af634af20fcec804cc519708747df0bdb873e1dc"
    sha256 cellar: :any,                 arm64_sequoia: "05d68740efe2dd856740be689062834e64119434697b5337b35ed49c1a9b0a99"
    sha256 cellar: :any,                 arm64_sonoma:  "52f57416922f24a284c264f4e4930a65e48b30ef7fae1b589698ec998f6349c9"
    sha256 cellar: :any,                 sonoma:        "be46d21b8a9ba1aca12b15ccd20ccf0bb32901c7cceac242dc9a32d021fb1a22"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7986dfc20bfac754dd20514ed3c83d25b20f2e61d7b4d22c22d92b78fb16008c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "483a1686e2333f2730aa1878b488b9cf97a486759076e9ade3559bbae5688709"
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
