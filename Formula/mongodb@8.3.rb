# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.9.tgz"
  sha256 "9ecf4f6005e1adbb0e5c59c55ff2e9c8347983060aac472043ee3b8570e816f3"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "50bfe6e0fbaed8d7bd2124f60ba11d86edb7547c16fdfc356e90e1bdbed5e42d"
    sha256 cellar: :any, arm64_tahoe:       "97ce4a0ae1b1807151a1b1b8d7741bdb73b46ddda3d3b71f84d644d59b02e36c"
    sha256 cellar: :any, arm64_sequoia:     "97fe61b627c5578c6e9600343d02bdb59ae0434e9d497452cafd249d2b33ee21"
    sha256 cellar: :any, arm64_linux:       "31662c0df3757a2362b94b5af419e7d09360756ccdb213ffef6a2637699cea72"
    sha256 cellar: :any, x86_64_linux:      "08c90b3a272090131bd5f0d44d12ebbb07183866454bc8818a6cb66e620295dc"
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
