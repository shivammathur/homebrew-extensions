# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.1.tgz"
  sha256 "2738972432d36c370fde3c76c208c31bd5a7a0afc4a7705874f92f322f3d2786"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a7b28f98ecf35d9ccddaa300bd6de6aa55872e1bd710286e28d48af705452096"
    sha256 cellar: :any,                 arm64_sequoia: "d53b98199fbfb2266e5377c79d2ba4afc13a4e15aaae5ccc6447262ffd2108e2"
    sha256 cellar: :any,                 arm64_sonoma:  "944bf0fac1b499955ee1078f0b4dd3d1fc0d40975b0f37043780a39dfcb58638"
    sha256 cellar: :any,                 sonoma:        "120a806e200e4afae89fa83c109aaa79954c7a10d8b86baad0aeab22657f0d77"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "838fcc18161ef1a3d446c8271368f2749c6422d1a5ef89aa7934ee86c73e9713"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "10ce25ebed1a3c1d95157d2007d95b1ed0504a6898f413322b0c6de01a4fead3"
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
