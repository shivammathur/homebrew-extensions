# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT70 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.9.2.tgz"
  sha256 "95e832c5d48ae6e947bdc79f35a9f8f0bbd518f4aa00f1cef6c9eafbae02187d"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "967c827bee2522fae204c8c8d2222b478b0cbb4b9de729317f148984b78ae12c"
    sha256 cellar: :any,                 arm64_big_sur:  "edfe57edb4c6b4e2baf52a90da9a8abadeafaff8760fd316ca1f1decd8dc6fb4"
    sha256 cellar: :any,                 monterey:       "a443499e2c73dd7b6446e19a700fe8bba313de800121a6ee7d3a264d91afe1cc"
    sha256 cellar: :any,                 big_sur:        "97e52a25b42793663981972ce25729c3123a3efb3300abbab85947aa0a475d0b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b85cdda4fc64dd5ace893757d5129347dab4ed5cc9c3bceee89ed5329756cf45"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
  depends_on "snappy"
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
