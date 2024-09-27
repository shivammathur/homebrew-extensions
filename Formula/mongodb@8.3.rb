# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "3ca2272cc863278114859b079dffdc968d9e7281cc579b10ae295c717c9edea3"
    sha256 cellar: :any,                 arm64_sonoma:   "c4a825b12ef710850a568a0a9fb441eba83f1fd74756603b3bfb2cdfbc14278a"
    sha256 cellar: :any,                 arm64_ventura:  "099006d2e7a73e02d233868551da156f1f314ef11b3aea5d909162517b4f415a"
    sha256 cellar: :any,                 arm64_monterey: "75e962096577d2852066097157663f359674c41034ce348964b4eeadb3e809e0"
    sha256 cellar: :any,                 ventura:        "5f1008a862009b17f64b5c2b936611a2c6c75ce224d3e1102ebfca1b7bb61bc9"
    sha256 cellar: :any,                 monterey:       "348e5237282b9d5ba8ae45f65f3d539c0b5691af739a8b5c7e898a2de804c711"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4c4f3e3567573145ef6f480df0248104ffb3c152e5bb8bcda60490cb2e2dd13e"
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
