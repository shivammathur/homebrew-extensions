# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT71 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "fd0dee764e2b0aebfda1b281c99ef32085220a45c67d0cc2c6b501a852ebc965"
    sha256 cellar: :any,                 big_sur:       "3f581943884ea1c374c3e354549d48e093f0f3a87fe6f287654ced60c2adde87"
    sha256 cellar: :any,                 catalina:      "6f930493583a96ff631c586007fb79e44097f7a5a7d868b0e8353f54ba590f37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2357288a4b8d790f453ad2e8a9adff07a90ad7155428f8573a1e6110955c27c6"
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
