# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.0.tgz"
  sha256 "2717abd81cdff4a1ed1f08d9f77d9c3601a9d934e89bc5441617f7c0acd62d17"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "dce67d7a8ef27c8787b8e0049526e611c3b7d600618d6ce6452910de926cf311"
    sha256 cellar: :any,                 arm64_sonoma:  "c00ffe715d1acb84ec9d08ed2e4f304bf087e9c4653122fbbb039220c3fffbdb"
    sha256 cellar: :any,                 arm64_ventura: "40ec78b36e25737cdc03ed33e8470b4a16105e49ec2cfac974e1ab926aa26398"
    sha256 cellar: :any,                 ventura:       "64b4b983d12a67f51cbb3aa1880f6a48bced51610d2f79a3ba53fc246acb6f52"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ac7a320764a2b257143ee735ae543b2df2a2369b810ef415429be82305fae91f"
  end

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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
