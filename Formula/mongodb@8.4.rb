# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "479e6ee39236c5da34161b53b233ee41c384175038bfd2c5460777deb142df6b"
    sha256 cellar: :any,                 arm64_sonoma:  "e0a12b8ba20558eb9cfb2949cd183312f13d73f39700e1942fb2ece544fb5d8f"
    sha256 cellar: :any,                 arm64_ventura: "65a9f2e3c20bf0b6a9ffab58b2fde730ef0dfe9ca9cce5025b3e1019a8450adb"
    sha256 cellar: :any,                 ventura:       "53e4c74292d3a46d28206ada2dc15b35c0c81cdec261352e3d579b395a72eaaf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "63675cdb17f4408cd2a40993ad6cee5bc5fa6f70406b15982743df35ee187baa"
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
