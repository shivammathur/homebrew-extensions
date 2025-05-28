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
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.16"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "0c433a5c7efa3d6c87ac2230bc748f6d1d4617d30796c4c441a6cbad84e8a296"
    sha256 cellar: :any,                 arm64_sonoma:  "13ab300014976514b0b70b5adce58346fde8a0cccf795128486b824656fbf776"
    sha256 cellar: :any,                 arm64_ventura: "42fb44a4db819a01605496866620f620757cb412aeac4bd9a9df844c97970ccf"
    sha256 cellar: :any,                 ventura:       "48a360b74558f3cbe4b72a73c9f550cc9c299dff26b3b4be677bf15edfefea33"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f7e9c2bc7082415f4f660cdaf593d8e12cce14b73c26fc6d86b3a30fc84837a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b7adc19e2da434b0f758790b7c1ba2fc46523063e10ecf65b31de32817e9b0ea"
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
