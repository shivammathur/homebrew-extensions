# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.8.tgz"
  sha256 "64bcb151b4c5c3f17dc1dfd949a35aed2c10b6230332861a5ad7aa9cdff44b2a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "94475b028cfeb6126040e0cc5788b515550d1b4958d109a9d8644177ce0e9f37"
    sha256 cellar: :any, arm64_tahoe:       "e55ae41281033d3a0101c4fc774ef58fd9ff79cd64767fa45e997f5e7e2b2955"
    sha256 cellar: :any, arm64_sequoia:     "58b5eba1630e49d7db65ec5c30ce90774465a8818a7ff0256cd864fba4da40b3"
    sha256 cellar: :any, arm64_linux:       "bfd4f56ef7dee1ac6b5f083a085abbf027a5b03c767a2742012e93188d86f362"
    sha256 cellar: :any, x86_64_linux:      "095764bb55dba92a67cc5acafee5b532b842944b5656bc928f413f70f2585860"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
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
