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
    sha256 cellar: :any,                 arm64_tahoe:   "e6ff997f6197a9a45c5ff547c2648f9e40a54ba3c3a13799e23b18a94e6e4959"
    sha256 cellar: :any,                 arm64_sequoia: "fe766d61e1a65d74e87359b6defc8df7e4dddbff6065757c199b22d3fa0d65b8"
    sha256 cellar: :any,                 arm64_sonoma:  "8b0675854eaeff6bd78488e96216a1c3b939f49294d0bc16daae0a4305564899"
    sha256 cellar: :any,                 sonoma:        "031ebb40627bf320d4c5cdc91126a4b781f06a488c19ab3b87b4a80d4f0d308a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "eca853c5cf376d2e326a608d99ca5a1898ad656a255f6756929ac1a9892cd572"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a48109dc38bfb3efbf01a3b1e8f9653b28e9fc5787855c19c321fcd0c1809ce4"
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
