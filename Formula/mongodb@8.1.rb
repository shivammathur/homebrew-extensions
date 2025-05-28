# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "9a765829c6b26e66db862510ee5db4916143118dfc2f426726aa4c082d138ff3"
    sha256 cellar: :any,                 arm64_sonoma:  "c039b6f55884ff4b2b5367850468b38b04c3f9c23a1f92bd46abffdb2dbed9e0"
    sha256 cellar: :any,                 arm64_ventura: "2fc08d78c8105588944f1a9a94ba9c3545f38c1d7897915f444d2d104c9137b9"
    sha256 cellar: :any,                 ventura:       "7f3589fef7a2b0b27c80d868361e558a3304af858a9cc53b60c6997f61b8c60c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "eb7fa0238e800b5f5efc7323d495c6b061eda07c137cd78ddd15c198a5044263"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a877f32131d01289fd8f686f4f63a7ac14a9b4bf28f3392168d54440e662acba"
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
