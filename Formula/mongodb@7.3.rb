# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.16"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "b2b38388bb7cb31c365040ce411dd36c1c7f241965ad9ca955108dd1b2637dd4"
    sha256 cellar: :any,                 arm64_sonoma:  "2db87712496a18500ad118989adc7109210e49036a25450aab6aed2eefb0374f"
    sha256 cellar: :any,                 arm64_ventura: "ccdf7f9969ff137714e14a51dd56a783d883386bfe286a813350802cd8a18939"
    sha256 cellar: :any,                 ventura:       "4b257810d6404cda6f86958b3f4b16fa5f5b3824c3539108175d87ea62b997fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9879b18311581da17b271c0e66494a168a2baaf93d7288bcc672175545bf3fbf"
  end

  depends_on "icu4c@75"
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
