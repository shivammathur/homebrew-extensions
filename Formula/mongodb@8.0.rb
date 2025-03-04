# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "51bfdafc8a42a6cc933f068d14c07b23d5dcea9df925d145c5cba8ec8b27b52b"
    sha256 cellar: :any,                 arm64_sonoma:  "e22bd0f296e882f9451f528635dd4ca279bafd324ea4737c802f70b0ff4d2268"
    sha256 cellar: :any,                 arm64_ventura: "62f0ace7ad828da26a987c099ae8a3e335d6b1a7954826a2b4045b130e0e6f4d"
    sha256 cellar: :any,                 ventura:       "f1827be0a39f2785b75ed39ecb2693fbd77eea6afdb21b38500bc8cd23c3f79b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "db65bc4cfda5b6d30369898873d1fe4948356a3197b0641798d5b4fff2e63946"
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
