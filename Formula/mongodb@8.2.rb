# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.3.tgz"
  sha256 "4f2c4e417fb606b462e870ec03656f3a97ba0b399dc24a6d9d153e9846134388"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "f44b074adc0f409010367299980c484c398ccf163542947b402813fef356f52c"
    sha256 cellar: :any,                 arm64_big_sur:  "8b4ed1e6fd5c6409d7e4c5f46d1be08dab9228a3dff3f7a073e7b0d44d8a0885"
    sha256 cellar: :any,                 ventura:        "f5b123250791ee9646b57980663865a11720fb615599d71a5a208ffcc2ab8b65"
    sha256 cellar: :any,                 monterey:       "3011baa5c2be76c66f3eea71db81f5551f540989a87507d75c88a2f78903639d"
    sha256 cellar: :any,                 big_sur:        "eb2957086d984b44a82a6e5bb5ac1c7452b93337daf8a2b4670146953bfe223e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0a5745faaf9fe358897cd1b318894ab87980a3e87a4f468ea3adabbc71b75b78"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
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
