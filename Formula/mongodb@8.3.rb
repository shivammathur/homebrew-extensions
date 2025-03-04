# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "f37707ad5eaec9d332dede60366ccfe64717051ce102fff2829d2868a99ebba7"
    sha256 cellar: :any,                 arm64_sonoma:  "c36f837b615f5cfbb830b9980fda96a5e35301187806600f985585a2a452db33"
    sha256 cellar: :any,                 arm64_ventura: "ad72453fa8232c7c1a15654f3eea39ab5ddf8d4cc76d27a7901fa21a3bcfe4e3"
    sha256 cellar: :any,                 ventura:       "ac27c42fd025c82835d5e7c9ca9f9bdd1b5604f02c66435df19f5a23e6bcc04a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c33c1c654c0adfd446f6f00edd554a5b85b1bc76b0f944c9d72bfac8c33995b"
  end

  depends_on "icu4c@76"
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
