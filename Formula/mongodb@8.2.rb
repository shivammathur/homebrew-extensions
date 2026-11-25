# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "dd8a702459c113610c3900e993e334f7aa048fe248b993726fe59502c5c5d179"
    sha256 cellar: :any, arm64_tahoe:       "331df0f92d933aec2ac53892977a01e9f86121a0d49e6e805947e2b8518250ba"
    sha256 cellar: :any, arm64_sequoia:     "5d5a48059221320300185104690b72132de755cb5260120b5e2f2824e88796a1"
    sha256 cellar: :any, arm64_linux:       "d9b26ca3a2f431db9b805cae0c61b6326a804fbc13e9cd1858ab759d3597ec17"
    sha256 cellar: :any, x86_64_linux:      "7d8146920ac579a75129bf5dbd867f375e42efaa5c0fa6edfa08074cea5c5b5d"
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
