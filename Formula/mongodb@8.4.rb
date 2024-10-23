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
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "1069e41908464ed40c34b69e5b28b14eaf4be8056446618772699247b31f1ab1"
    sha256 cellar: :any,                 arm64_sonoma:  "a3684c8c72ebdb2138f8386365de1c02873f858c8ab85e274ac6f8817d03292a"
    sha256 cellar: :any,                 arm64_ventura: "19af3a44228018a3cec0c7cb70017b4e6335ce400d22845f39414379e3d693cd"
    sha256 cellar: :any,                 ventura:       "4ee85531297866fd5f3e9f21f7f4100457457bf39b909acb032c6e2db862b642"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c8a74c13d04e910dd224acaae1fc66a28555515ced4096eee8a3c16aaa9eca4"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
