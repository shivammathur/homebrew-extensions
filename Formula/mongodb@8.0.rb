# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "48c6fa0fe36b465ad01b8f41cbe34edbb7371d39c68acdfbe5fb4ab2fde40441"
    sha256 cellar: :any,                 arm64_sonoma:  "2117d7b608366c37c64476dc4d521426cb82293687f33a160cbab59145c06bc9"
    sha256 cellar: :any,                 arm64_ventura: "c8fb35ac42a5bd26f42a31dce7cf74d23dace37c38d0944587cfda7a0cabfb5e"
    sha256 cellar: :any,                 ventura:       "bc9f11cadf34580989400f95843d67f9488d9bcb0e06b5b2a75437747d48cdc9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5f0fe48f3a3e8656424c405863245c4f3c5d2cbf5ac4a72dfdca03e06e961ce1"
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
