# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.2.tgz"
  sha256 "68547dcfb05d424c5bcb82d20fa4c41a5672aacf9953e6f301c89a4830f78db2"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "c060f1cf50aa9961866c99ce80301939ced3f4923c220e0b1e3bec1b988505ad"
    sha256 cellar: :any,                 arm64_sequoia: "73513af03acd44a11c6536bf07ed287e951a3381aeb355b41da543756677856f"
    sha256 cellar: :any,                 arm64_sonoma:  "2584e2588c7ca0579e9a9d3f2aec4d9291d88e2b87ccd297fbf949720a1dd2ed"
    sha256 cellar: :any,                 sonoma:        "8ef9827b796508bfcd42956c750edd386ab2d605b21e4e99d78ff3ac8859b74e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6f62c337fc74e485b034b0bec4b328fe2bb40493702fe3ed38842863adcb4b2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "62354eb4015c69c3cb959032b20b765b024cabc74964e11f7981c4df26a31c74"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@77"
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
